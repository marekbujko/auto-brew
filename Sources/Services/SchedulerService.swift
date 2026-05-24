import Foundation
import os

/// Triggers `BrewManager.runFullUpdate()` in either idle or scheduled mode.
/// Also watches sleep/wake to catch up on runs missed during sleep. Doesn't
/// react to settings changes on its own — callers invoke `restartScheduling()`.
@Observable
@MainActor
final class SchedulerService {
    static let shared = SchedulerService()

    private(set) var state: SchedulerState = .idle

    private let settings = SettingsStore.shared
    private let brewManager = BrewManager.shared
    private let sleepWakeObserver = SleepWakeObserver()
    private let notificationManager = NotificationManager.shared
    private let pendingStore = PendingUpdatesStore.shared
    private let ledgerStore = UpdateLedgerStore()
    private let historyStore = UpgradeHistoryStore.shared
    private let logger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Scheduler")

    private var pollingTask: Task<Void, Never>?
    private var scheduledTask: Task<Void, Never>?

    /// Scheduler-level reentrancy guard. `BrewManager.isRunning` toggles per
    /// stage so it can't tell us "a whole pipeline is in flight" — between
    /// `runUpdate` and `runUpgrade` the flag is briefly false and a second
    /// trigger could slip in. This bool covers the whole sequence.
    private var pipelineInProgress = false

    var lastRunDate: Date? { settings.lastRunDate }
    var isRunning: Bool { brewManager.isRunning }
    var currentStage: BrewStage? { brewManager.currentStage }

    func start() {
        logger.info("Scheduler starting with mode: \(self.settings.triggerMode.rawValue)")

        sleepWakeObserver.onWakeWithMissedRun = { [weak self] in
            self?.handleMissedRun()
        }
        sleepWakeObserver.startObserving()

        notificationManager.onRunNowRequested = { [weak self] in
            Task { @MainActor in
                await self?.triggerManualRun()
            }
        }

        restartScheduling()
    }

    func restartScheduling() {
        pollingTask?.cancel()
        scheduledTask?.cancel()

        switch settings.triggerMode {
        case .idle:
            state = .waitingForIdle
            startIdlePolling()
        case .scheduled:
            state = .waitingForSchedule
            startScheduledTimer()
        }
    }

    func triggerManualRun() async {
        await runBrewUpdate()
    }

    // MARK: - Idle Mode

    /// 60-second polling is plenty — the user won't notice 30 seconds either
    /// way, and we avoid waking the CPU every second.
    private func startIdlePolling() {
        pollingTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(60))
                guard !Task.isCancelled else { break }
                await self?.checkIdleAndRun()
            }
        }
    }

    private func checkIdleAndRun() async {
        guard !settings.didRunToday, !brewManager.isRunning else { return }

        guard let idleSeconds = IdleDetector.systemIdleTime() else {
            logger.warning("Could not read idle time")
            return
        }

        let requiredSeconds = TimeInterval(settings.idleMinutes * 60)
        if idleSeconds >= requiredSeconds {
            logger.info("Idle threshold reached (\(Int(idleSeconds))s >= \(Int(requiredSeconds))s)")
            await runBrewUpdate()
        }
    }

    // MARK: - Scheduled Mode

    private func startScheduledTimer() {
        scheduledTask = Task { [weak self] in
            while !Task.isCancelled {
                guard let self else { break }
                guard let delay = self.secondsUntilNextRun() else {
                    try? await Task.sleep(for: .seconds(60))
                    continue
                }

                self.logger.info("Next scheduled run in \(Int(delay)) seconds")

                if delay > 0 {
                    try? await Task.sleep(for: .seconds(delay))
                }
                guard !Task.isCancelled else { break }

                if !self.settings.didRunToday {
                    await self.runBrewUpdate()
                }

                // One-hour cooldown — otherwise the loop would immediately
                // compute `secondsUntilNextRun` for tomorrow and spin needlessly.
                try? await Task.sleep(for: .seconds(3600))
            }
        }
    }

    private func secondsUntilNextRun() -> TimeInterval? {
        let calendar = Calendar.current
        let now = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = settings.scheduledHour
        components.minute = settings.scheduledMinute

        guard var target = calendar.date(from: components) else { return nil }

        if target <= now {
            guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: target) else { return nil }
            target = tomorrow
        }

        return target.timeIntervalSince(now)
    }

    // MARK: - Brew Execution

    private func runBrewUpdate() async {
        guard !pipelineInProgress else {
            logger.info("Brew run skipped — pipeline already in progress")
            return
        }

        guard brewManager.isHomebrewInstalled else {
            state = .failed("Homebrew not installed")
            logger.warning("Brew update skipped — Homebrew not installed")
            return
        }

        pipelineInProgress = true
        defer { pipelineInProgress = false }

        var upgradeError: Error?

        do {
            // 1. brew update — refresh the index so fetchOutdated sees latest.
            state = .running(.updating)
            try await brewManager.runUpdate()

            // 2. Pull the outdated list and route each entry through the
            //    update policy. Stuff that's auto-installable goes into the
            //    upgrade call; anything needing approval lands in the
            //    pending store.
            await brewManager.fetchOutdated()
            let outdated = brewManager.outdatedPackages
            let now = Date()

            let evaluator = UpdateEvaluator(
                defaults: settings.policyDefaults,
                overrides: settings.packageOverrides,
                existingPending: pendingStore.updates
            )
            let bundle = evaluator.evaluate(outdated, ledger: ledgerStore.ledger, now: now)

            // Persist firstSeen + housekeeping on the ledger so the cool-off
            // window is measured from the first sighting next run too.
            for package in outdated {
                let kind: PackageKind = package.isCask ? .cask : .formula
                _ = ledgerStore.touch(kind: kind, token: package.name, version: package.newVersion, now: now)
            }
            let activeKeys = Set(outdated.map { package -> String in
                let kind: PackageKind = package.isCask ? .cask : .formula
                return UpdateLedger.key(kind: kind, token: package.name, version: package.newVersion)
            })
            ledgerStore.purge(keeping: activeKeys)

            // Carry the user's prior decisions forward and surface anything
            // new that needs a verdict.
            let priorPendingCount = pendingStore.pendingCount
            pendingStore.replace(with: bundle.needsApproval)
            let newPendingCount = pendingStore.pendingCount

            // 3. Pick everything that's allowed to install right now.
            let formulaeToUpgrade = bundle.autoInstall.filter { !$0.isCask }.map(\.name)
            let casksToUpgrade = bundle.autoInstall.filter { $0.isCask }
            let casksToUpgradeNames = casksToUpgrade.map(\.name)
            let approvedTokens = Set(pendingStore.approvedTokens)

            // Before brew rewrites the .app, capture user data per cask so
            // the History view can offer a one-click rollback. Failures are
            // swallowed — never block an upgrade because a snapshot didn't
            // take.
            var preSnapshots: [String: PreUpgradeContext] = [:]
            if settings.autoSnapshotBeforeUpgrade && !casksToUpgrade.isEmpty {
                preSnapshots = await capturePreUpgradeSnapshots(forCasks: casksToUpgrade)
            }

            if formulaeToUpgrade.isEmpty && casksToUpgradeNames.isEmpty {
                logger.info("Nothing to upgrade — \(bundle.waitingForCooldown.count) waiting, \(bundle.needsApproval.count) pending approval")
            } else {
                do {
                    try await brewManager.runUpgrade(formulae: formulaeToUpgrade, casks: casksToUpgradeNames)
                    // Only drop approved entries from the pending list after
                    // the upgrade actually went through — a failure should
                    // leave them queued so the next run retries.
                    pendingStore.remove(tokens: approvedTokens)
                    recordUpgradeHistory(for: casksToUpgrade, preSnapshots: preSnapshots, succeeded: true)
                } catch {
                    // Swallow here so cleanup still runs; rethrow shape is
                    // preserved via `upgradeError` below.
                    upgradeError = error
                    recordUpgradeHistory(for: casksToUpgrade, preSnapshots: preSnapshots, succeeded: false)
                }
            }

            // 4. cleanup — disk hygiene regardless of upgrade outcome.
            do {
                try await brewManager.runCleanup()
            } catch {
                // If the upgrade succeeded but cleanup failed, surface that;
                // otherwise the upgrade failure takes precedence.
                if upgradeError == nil { upgradeError = error }
            }

            if let upgradeError {
                throw upgradeError
            }

            settings.lastRunDate = Date()
            if settings.autoCleanupSnapshots {
                do {
                    try SnapshotService.shared.cleanup(olderThanDays: settings.snapshotRetentionDays)
                } catch {
                    logger.error("Snapshot cleanup failed: \(error.localizedDescription)")
                }
            }

            if let stage = brewManager.currentStage {
                state = .running(stage)
            }
            state = .completed(Date())
            sleepWakeObserver.clearMissedRun()

            // Notification policy:
            //   - completion notification: always (when notifications are on)
            //   - pending-approval notification: only when *new* entries
            //     showed up since the last run, so the user isn't pinged
            //     about the same list over and over.
            if settings.showNotifications {
                notificationManager.showCompletionNotification(success: true)
                if newPendingCount > priorPendingCount {
                    let preview = pendingStore.updates
                        .filter { $0.decision.isPending }
                        .prefix(3)
                        .map(\.displayName)
                    notificationManager.showPendingApprovals(count: newPendingCount, sampleNames: Array(preview))
                }
            }
            logger.info("Brew run done — \(bundle.autoInstall.count) upgraded, \(bundle.waitingForCooldown.count) waiting, \(newPendingCount) pending")
        } catch {
            state = .failed(error.localizedDescription)
            if settings.showNotifications {
                notificationManager.showCompletionNotification(success: false, detail: error.localizedDescription)
            }
            logger.error("Brew update failed: \(error.localizedDescription)")
        }
    }

    // MARK: - Missed Run

    private func handleMissedRun() {
        guard settings.showNotifications else {
            Task { await triggerManualRun() }
            return
        }
        notificationManager.showMissedRunNotification()
    }

    // MARK: - Pre-Upgrade Snapshot + History

    /// Carries the snapshot the scheduler took right before a cask was
    /// upgraded. `snapshotID` is `nil` when the cask had nothing to snapshot
    /// (CLI-only cask, app not under /Applications) or the snapshot failed;
    /// the history row is still written so the audit trail is complete.
    private struct PreUpgradeContext {
        let snapshotID: UUID?
        let bundleID: String?
        let displayName: String
    }

    /// Best-effort snapshot of each cask's user data right before its
    /// upgrade. Looks up the bundle ID via `InstalledAppsStore` (refreshing
    /// once if the store is empty). Every error path is logged and produces
    /// a `nil`-snapshot context rather than throwing — a snapshot failure
    /// must never block the upgrade itself.
    private func capturePreUpgradeSnapshots(forCasks casks: [OutdatedPackage]) async -> [String: PreUpgradeContext] {
        if InstalledAppsStore.shared.apps.isEmpty {
            await InstalledAppsStore.shared.refresh()
        }
        let apps = InstalledAppsStore.shared.apps
        var result: [String: PreUpgradeContext] = [:]
        for cask in casks {
            // Honour scheduler cancellation between snapshots — a 10-cask pass
            // on a slow disk can easily run several minutes, long enough for
            // the user to flip trigger mode or quit.
            if Task.isCancelled { return result }
            let app = apps.first(where: { ($0.caskToken ?? "").lowercased() == cask.name.lowercased() })
            guard let bundleID = app?.bundleID else {
                logger.info("Pre-upgrade snapshot skipped for \(cask.name, privacy: .public) — no installed .app under brew management")
                result[cask.name] = PreUpgradeContext(snapshotID: nil, bundleID: nil,
                                                     displayName: app?.displayName ?? cask.name)
                continue
            }
            let displayName = app?.displayName ?? cask.name
            do {
                let snapshot = try await SnapshotService.shared.createSnapshot(
                    bundleID: bundleID,
                    displayName: displayName,
                    caskToken: cask.name,
                    sourceAppVersion: cask.currentVersion
                )
                result[cask.name] = PreUpgradeContext(snapshotID: snapshot.id,
                                                     bundleID: bundleID,
                                                     displayName: displayName)
                logger.info("Pre-upgrade snapshot \(cask.name, privacy: .public) → \(snapshot.id)")
            } catch {
                logger.warning("Pre-upgrade snapshot failed for \(cask.name, privacy: .public): \(error.localizedDescription, privacy: .public)")
                result[cask.name] = PreUpgradeContext(snapshotID: nil, bundleID: bundleID,
                                                     displayName: displayName)
            }
        }
        return result
    }

    /// `succeeded` is per-batch, not per-cask: `BrewManager.runUpgrade` reports
    /// aggregate exit status only, so a single cask warning that brew swallows
    /// will show up here as `succeeded: true` even though that one upgrade did
    /// not really apply. The pre-upgrade snapshot still exists either way, so
    /// rollback stays correct; the only loss is a misleading green tick in the
    /// history row. Per-cask outcome tracking would require teaching
    /// `BrewManager` to parse `brew upgrade --cask`'s per-line output — out of
    /// scope for the snapshot/history feature.
    private func recordUpgradeHistory(for casks: [OutdatedPackage],
                                      preSnapshots: [String: PreUpgradeContext],
                                      succeeded: Bool) {
        let now = Date()
        for cask in casks {
            let ctx = preSnapshots[cask.name]
            historyStore.append(UpgradeHistoryEntry(
                id: UUID(),
                timestamp: now,
                token: cask.name,
                displayName: ctx?.displayName ?? cask.name,
                fromVersion: cask.currentVersion,
                toVersion: cask.newVersion,
                bundleID: ctx?.bundleID,
                snapshotID: ctx?.snapshotID,
                succeeded: succeeded
            ))
        }
    }

    private init() {}
}
