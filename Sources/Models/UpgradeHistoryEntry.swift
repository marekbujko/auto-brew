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
///
/// `outcome` carries per-cask success/failure — see `CaskUpgradeOutcome`.
/// Earlier versions of this model used a `succeeded: Bool` that mirrored
/// `BrewManager.runUpgrade`'s aggregate exit status; the custom decoder
/// below still reads those rows from disk so an in-place upgrade of
/// AutoBrew never silently drops the user's existing history.
struct UpgradeHistoryEntry: Codable, Sendable, Equatable, Identifiable {
    let id: UUID
    let timestamp: Date
    let token: String
    let displayName: String
    let fromVersion: String
    let toVersion: String
    let bundleID: String?
    let snapshotID: UUID?
    let outcome: CaskUpgradeOutcome

    init(id: UUID, timestamp: Date, token: String, displayName: String,
         fromVersion: String, toVersion: String, bundleID: String?,
         snapshotID: UUID?, outcome: CaskUpgradeOutcome) {
        self.id = id
        self.timestamp = timestamp
        self.token = token
        self.displayName = displayName
        self.fromVersion = fromVersion
        self.toVersion = toVersion
        self.bundleID = bundleID
        self.snapshotID = snapshotID
        self.outcome = outcome
    }

    private enum CodingKeys: String, CodingKey {
        case id, timestamp, token, displayName, fromVersion, toVersion
        case bundleID, snapshotID, outcome
        case succeeded // legacy — read-only; never written
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        timestamp = try c.decode(Date.self, forKey: .timestamp)
        token = try c.decode(String.self, forKey: .token)
        displayName = try c.decode(String.self, forKey: .displayName)
        fromVersion = try c.decode(String.self, forKey: .fromVersion)
        toVersion = try c.decode(String.self, forKey: .toVersion)
        bundleID = try c.decodeIfPresent(String.self, forKey: .bundleID)
        snapshotID = try c.decodeIfPresent(UUID.self, forKey: .snapshotID)

        if let parsedOutcome = try c.decodeIfPresent(CaskUpgradeOutcome.self, forKey: .outcome) {
            outcome = parsedOutcome
        } else if let legacy = try c.decodeIfPresent(Bool.self, forKey: .succeeded) {
            // Pre-three-state schema: succeeded:true → .succeeded, false →
            // .failed. We never wrote .attempted to disk under the old
            // schema, so the mapping is lossless.
            outcome = legacy ? .succeeded : .failed
        } else {
            outcome = .attempted
        }
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(id, forKey: .id)
        try c.encode(timestamp, forKey: .timestamp)
        try c.encode(token, forKey: .token)
        try c.encode(displayName, forKey: .displayName)
        try c.encode(fromVersion, forKey: .fromVersion)
        try c.encode(toVersion, forKey: .toVersion)
        try c.encodeIfPresent(bundleID, forKey: .bundleID)
        try c.encodeIfPresent(snapshotID, forKey: .snapshotID)
        try c.encode(outcome, forKey: .outcome)
        // `succeeded` is intentionally omitted: it is a legacy read-only key
        // and should not appear in newly written entries.
    }
}
