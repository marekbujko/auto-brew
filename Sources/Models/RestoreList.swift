import Foundation

/// Index file written into a multi-app restore archive. Each `Entry` points at
/// one snapshot bundle that lives next to the list inside the same archive;
/// `archiveFilename` is relative so the archive stays portable across hosts.
struct RestoreList: Codable, Sendable {
    struct Entry: Codable, Hashable, Sendable {
        let bundleID: String
        let caskToken: String?
        let archiveFilename: String
    }

    /// Bumped whenever the on-disk layout changes incompatibly. `SnapshotService`
    /// refuses lists with a version newer than it knows.
    let schemaVersion: Int
    let createdAt: Date
    let originHost: String
    let entries: [Entry]
}
