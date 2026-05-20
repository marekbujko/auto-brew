import Foundation

/// A single file or directory inside a snapshot. Restore uses it to rebuild
/// the original path and (for files) to verify integrity against `sha256`.
struct SnapshotComponent: Codable, Hashable, Sendable {
    enum Kind: String, Codable, Sendable { case file, directory }
    let originalPath: String       // `~` as the home placeholder
    let relativeArchivePath: String // path inside data/
    let kind: Kind
    let sha256: String?            // files only
    let byteSize: Int64
}
