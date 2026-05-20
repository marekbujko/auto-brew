import Foundation

/// A `.app` discovered in `/Applications` (or a user Applications folder),
/// optionally joined with the cask that installed it.
struct InstalledApp: Identifiable, Hashable, Sendable {
    let bundleID: String
    let displayName: String
    let appPath: URL
    let version: String?
    let caskToken: String?
    let isHomebrewManaged: Bool

    var id: String { bundleID }
}
