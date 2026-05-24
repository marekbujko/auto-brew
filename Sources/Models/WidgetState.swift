import Foundation

/// Snapshot of "what's interesting about AutoBrew right now", written by
/// the main app into the App Group container and read by the widget
/// extension. The widget never reaches into the main app's storage
/// directly — extensions are sandboxed and that path is invisible to
/// them — so this struct is the single source of truth for the widget.
///
/// The shape is intentionally compact (per-entry strings, no nested
/// references back into `UpgradeHistoryEntry`/`SnapshotService`) so the
/// timeline provider can decode + render the file on every refresh
/// without ever touching the heavier services that live in the main
/// process.
struct WidgetState: Codable, Sendable, Equatable {
    /// One row from the upgrade history, shrunk to what the widget can
    /// actually paint on a small/medium/large surface.
    struct UpgradeRow: Codable, Sendable, Equatable, Identifiable {
        let id: UUID
        let token: String
        let displayName: String
        let fromVersion: String
        let toVersion: String
        let outcome: CaskUpgradeOutcome
        let timestamp: Date
    }

    /// Count of pending-approval entries the user has not yet decided on.
    /// Drives the headline number on the small widget and the badge on
    /// the medium/large widgets.
    let pendingApprovals: Int

    /// Up to three names for the medium-size body. Truncated by the
    /// writer, not the widget, so the widget never has to know the
    /// truncation policy.
    let pendingSampleNames: [String]

    /// Most recent five history rows. The widget consumes a prefix
    /// depending on family.
    let recentUpgrades: [UpgradeRow]

    /// `UpgradeHistoryEntry.id` of the newest failed cask whose
    /// pre-upgrade snapshot is still on disk — populated only when a
    /// real rollback is possible, otherwise nil. Used by the large
    /// widget's Roll Back button.
    let rollbackCandidateID: UUID?

    /// Wall-clock time of the last write. The widget surfaces this as a
    /// "Updated <relative>" footer so a stale file (main app not
    /// running) reads honestly rather than implying the data is fresh.
    let updatedAt: Date

    static let empty = WidgetState(
        pendingApprovals: 0,
        pendingSampleNames: [],
        recentUpgrades: [],
        rollbackCandidateID: nil,
        updatedAt: .distantPast
    )
}
