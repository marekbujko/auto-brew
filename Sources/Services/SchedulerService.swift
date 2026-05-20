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
    private let logger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Scheduler")

    private var pollingTask: Task<Void, Never>?
    private var scheduledTask: Task<Void, Never>?

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
        guard !brewManager.isRunning else { return }

        guard brewManager.isHomebrewInstalled else {
            state = .failed("Homebrew not installed")
            logger.warning("Brew update skipped — Homebrew not installed")
            return
        }

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
                _ = ledgerStore.touch(token: package.name, version: package.newVersion, now: now)
            }
            let activeKeys = Set(outdated.map { UpdateLedger.key(token: $0.name, version: $0.newVersion) })
            ledgerStore.purge(keeping: activeKeys)

            // Carry the user's prior decisions forward and surface anything
            // new that needs a verdict.
            let priorPendingCount = pendingStore.pendingCount
            pendingStore.replace(with: bundle.needsApproval)
            let newPendingCount = pendingStore.pendingCount

            // 3. Pick everything that's allowed to install right now.
            let approvedTokens = Set(pendingStore.approvedTokens)
            let installable = bundle.autoInstall.filter { !approvedTokens.contains($0.name) }
                + bundle.autoInstall.filter { approvedTokens.contains($0.name) }
            let formulaeToUpgrade = installable.filter { !$0.isCask }.map(\.name)
            let casksToUpgrade = installable.filter { $0.isCask }.map(\.name)

            if formulaeToUpgrade.isEmpty && casksToUpgrade.isEmpty {
                logger.info("Nothing to upgrade — \(bundle.waitingForCooldown.count) waiting, \(bundle.needsApproval.count) pending approval")
            } else {
                try await brewManager.runUpgrade(formulae: formulaeToUpgrade, casks: casksToUpgrade)
                // Approved entries that just got installed can drop out of the
                // pending list — they're no longer relevant.
                pendingStore.remove(tokens: approvedTokens)
            }

            // 4. cleanup — disk hygiene regardless of upgrade outcome.
            try await brewManager.runCleanup()

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
            logger.info("Brew run done — \(installable.count) upgraded, \(bundle.waitingForCooldown.count) waiting, \(newPendingCount) pending")
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

    private init() {}
}
