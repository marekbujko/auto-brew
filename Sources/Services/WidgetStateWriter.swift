import Foundation
import WidgetKit
import os

private let widgetWriterLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "WidgetState")

/// Centralises every `WidgetState.json` write so the producers
/// (Scheduler, history store, pending store) stay one-liner sites.
/// Writes go to the App Group container — the only filesystem path
/// the sandboxed widget extension can actually read.
///
/// Failure modes are deliberately quiet: a missing App Group, a busy
/// disk, or an encoder error all log and return without throwing. The
/// widget will then render either the previous file or its
/// `.placeholder` until the next refresh succeeds.
@MainActor
enum WidgetStateWriter {
    /// Production-facing identifier. The same string must appear in
    /// `AutoBrew.entitlements` and `AutoBrewWidget.entitlements`. Kept
    /// here rather than `Bundle.main` reads so a test can override the
    /// container directory directly.
    static let appGroupIdentifier = "group.za.co.digitalfreedom.AutoBrew"

    /// Filename inside the App Group container.
    static let stateFilename = "WidgetState.json"

    /// Top-N history rows surfaced to the widget. Small + medium widgets
    /// show fewer; large shows the full prefix.
    static let recentUpgradesLimit = 5

    /// Names previewed in the pending-approvals badge.
    static let pendingSampleLimit = 3

    /// Snapshot the current state of the main app's stores and persist
    /// it. Safe to call from any producer that just mutated something
    /// the widget cares about.
    static func refresh(containerOverride: URL? = nil) {
        let pendingStore = PendingUpdatesStore.shared
        let historyStore = UpgradeHistoryStore.shared
        let snapshots = (try? SnapshotService.shared.listSnapshots()) ?? []
        let liveSnapshotIDs = Set(snapshots.map(\.id))

        let pendingCount = pendingStore.pendingCount
        let pendingNames = pendingStore.updates
            .filter { $0.decision.isPending }
            .prefix(pendingSampleLimit)
            .map(\.displayName)

        let rows: [WidgetState.UpgradeRow] = historyStore.entries
            .prefix(recentUpgradesLimit)
            .map { entry in
                WidgetState.UpgradeRow(
                    id: entry.id,
                    token: entry.token,
                    displayName: entry.displayName,
                    fromVersion: entry.fromVersion,
                    toVersion: entry.toVersion,
                    outcome: entry.outcome,
                    timestamp: entry.timestamp
                )
            }

        let rollbackCandidate = historyStore.entries.first { entry in
            entry.outcome == .failed
                && entry.snapshotID.map(liveSnapshotIDs.contains) == true
        }?.id

        let state = WidgetState(
            pendingApprovals: pendingCount,
            pendingSampleNames: Array(pendingNames),
            recentUpgrades: rows,
            rollbackCandidateID: rollbackCandidate,
            updatedAt: Date()
        )

        write(state: state, containerOverride: containerOverride)
    }

    /// Lower-level entry point used directly by tests so they can
    /// inject a fully-formed state and a temp directory without going
    /// through the production stores.
    static func write(state: WidgetState, containerOverride: URL? = nil) {
        guard let container = containerURL(override: containerOverride) else {
            widgetWriterLogger.warning("Skipping widget state write — App Group container unavailable")
            return
        }
        let target = container.appendingPathComponent(stateFilename)
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = [.sortedKeys]
            let data = try encoder.encode(state)
            try data.write(to: target, options: .atomic)
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            widgetWriterLogger.error("Widget state write failed: \(error.localizedDescription, privacy: .public)")
        }
    }

    /// Resolves the App Group container URL, honouring the optional
    /// override that tests use. Returns nil when the App Group is not
    /// provisioned — both in unit-test runs that do not link the
    /// entitlement and in unprivileged debug builds.
    static func containerURL(override: URL? = nil) -> URL? {
        if let override { return override }
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)
    }
}
