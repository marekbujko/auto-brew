import Foundation

/// One row in the upgrade history view. Records what AutoBrew upgraded,
/// when, and — when the pre-upgrade auto-snapshot policy was on for that
/// cask — the snapshot that was taken right before the upgrade so the user
/// can roll back to the previous user-data state with one click.
///
/// `snapshotID` is the AppSnapshot UUID, not a filesystem path: the snapshot
/// may have been deleted by retention or manual cleanup between the upgrade
/// and the moment the user opens the history view, so the UI must look up
/// the snapshot in `SnapshotService.listSnapshots()` and gate the rollback
/// button on it actually existing.
struct UpgradeHistoryEntry: Codable, Sendable, Equatable, Identifiable {
    let id: UUID
    let timestamp: Date
    let token: String
    let displayName: String
    let fromVersion: String
    let toVersion: String
    let bundleID: String?
    let snapshotID: UUID?
    let succeeded: Bool
}
