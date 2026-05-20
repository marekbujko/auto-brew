import Foundation

/// In-memory view of a snapshot stored on disk. The header fields are read from
/// `manifest.json`; `bundleURL` is the directory that holds both the manifest
/// and the `data/` payload. Anything beyond these fields is recomputed on load.
struct AppSnapshot: Identifiable, Hashable, Sendable {
    let id: UUID
    let bundleID: String
    let displayName: String
    let createdAt: Date
    let caskToken: String?
    let sourceAppVersion: String?
    let totalBytes: Int64
    let bundleURL: URL

    var manifestURL: URL { bundleURL.appendingPathComponent("manifest.json") }
    var dataDir: URL { bundleURL.appendingPathComponent("data", isDirectory: true) }
}
