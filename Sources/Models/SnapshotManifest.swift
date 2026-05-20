import Foundation

/// `manifest.json` at the root of every snapshot bundle. Carries enough
/// provenance (`originHost`, `originUser`, `sourceAppVersion`) to make cross-
/// machine restores diagnosable, plus the list of components needed to put the
/// payload back where it came from.
///
/// `schemaVersion` is the compatibility gate — a manifest with a newer version
/// than the running app is rejected outright rather than half-restored. Bump it
/// whenever the on-disk layout or component semantics change.
struct SnapshotManifest: Codable, Sendable {
    let id: UUID
    let bundleID: String
    let displayName: String
    let caskToken: String?
    let sourceAppVersion: String?
    let createdAt: Date
    let originHost: String
    let originUser: String
    let schemaVersion: Int
    let components: [SnapshotComponent]
}
