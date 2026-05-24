import AppIntents
import Foundation

/// Shortcut for "undo the last cask upgrade that broke." Mirrors the Roll
/// Back action on the failed-update notification: walks the upgrade
/// history newest-first looking for a failed row whose pre-upgrade
/// snapshot is still on disk, then runs the same transactional restore
/// the History view uses.
///
/// `token` is optional. Pass it to scope the search to one cask — useful
/// when the user knows which app went wrong. Without it the intent picks
/// the most recent failed cask with a live snapshot, regardless of
/// which.
struct RollBackLastUpgradeIntent: AppIntent {
    static let title: LocalizedStringResource = "Roll Back Last Cask Upgrade"
    static let description = IntentDescription("Restore the user data captured before the most recent failed cask upgrade.")
    static let openAppWhenRun: Bool = false

    @Parameter(
        title: "Cask Token",
        description: "Optional: limit the rollback to this cask. Leave empty for the most recent failed upgrade with a live snapshot.",
        default: ""
    )
    var token: String

    static var parameterSummary: some ParameterSummary {
        Summary("Roll back the last cask upgrade") {
            \.$token
        }
    }

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let trimmed = token.trimmingCharacters(in: .whitespaces)
        let scoped: String? = trimmed.isEmpty ? nil : trimmed

        let snapshots = (try? SnapshotService.shared.listSnapshots()) ?? []
        let liveIDs = Set(snapshots.map(\.id))

        // Newest-first by construction (UpgradeHistoryStore inserts at 0).
        let candidates = UpgradeHistoryStore.shared.entries
        let entry = candidates.first { row in
            guard row.outcome == .failed else { return false }
            guard let snapshotID = row.snapshotID, liveIDs.contains(snapshotID) else { return false }
            if let scoped, row.token.lowercased() != scoped.lowercased() { return false }
            return true
        }

        guard let entry else {
            if let scoped {
                throw AutoBrewIntentError.rollbackTargetMissingSnapshot(scoped)
            }
            throw AutoBrewIntentError.noRollbackCandidate
        }
        guard let snapshotID = entry.snapshotID,
              let snapshot = snapshots.first(where: { $0.id == snapshotID }) else {
            throw AutoBrewIntentError.snapshotMissingOnDisk
        }

        try await SnapshotService.shared.restoreSnapshot(snapshot, terminateApp: true)
        return .result(value: entry.token)
    }
}
