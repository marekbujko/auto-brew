import Foundation

/// A `.app` discovered in `/Applications` (or a user Applications folder),
/// joined with the cask token brew reports for it. A `nil` token means
/// either the user installed the app manually or its cask comes from a tap
/// AutoBrew can't see — either way, brew actions stay hidden in the UI.
struct InstalledApp: Identifiable, Hashable, Sendable {
    let bundleID: String
    let displayName: String
    let appPath: URL
    let version: String?
    let caskToken: String?

    var id: String { bundleID }
}
