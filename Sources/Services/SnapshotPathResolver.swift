import Foundation

/// Collects every standard location where macOS stores app data —
/// Preferences, Containers, Caches, Saved State, etc. Each path is checked
/// individually instead of recursively scanning `~/Library`, which would take
/// hours.
struct SnapshotPathResolver: Sendable {
    let bundleID: String
    let home: URL

    init(bundleID: String, home: URL = FileManager.default.homeDirectoryForCurrentUser) {
        self.bundleID = bundleID
        self.home = home
    }

    var groupContainerSearchRoot: URL { home.appendingPathComponent("Library/Group Containers") }

    func candidatePaths() -> [URL] {
        let lib = home.appendingPathComponent("Library")
        return [
            lib.appendingPathComponent("Preferences/\(bundleID).plist"),
            lib.appendingPathComponent("Application Support/\(bundleID)"),
            lib.appendingPathComponent("Containers/\(bundleID)"),
            lib.appendingPathComponent("Saved Application State/\(bundleID).savedState"),
            lib.appendingPathComponent("Caches/\(bundleID)"),
            lib.appendingPathComponent("WebKit/\(bundleID)"),
            lib.appendingPathComponent("HTTPStorages/\(bundleID)"),
            lib.appendingPathComponent("HTTPStorages/\(bundleID).binarycookies"),
            lib.appendingPathComponent("Cookies/\(bundleID).binarycookies")
        ]
    }

    /// Generic last-segment tokens that we refuse to match group containers on.
    /// Substring-matching on these would pull in unrelated containers — e.g.
    /// `com.usebruno.app` would hit Apple's `group.com.apple.stocks-news`
    /// because "apple" contains "app", and AutoBrew has no permission to read
    /// Apple's group containers.
    private static let genericLastSegments: Set<String> = [
        "app", "mac", "macos", "osx", "ios", "ipad", "tv", "watch"
    ]

    /// Group containers carry team-ID prefixes (e.g. `ABCDE12345.com.x.y`) or a
    /// `group.` prefix, so we substring-match on identifying tokens derived
    /// from the bundle ID instead of the bundle ID itself. We accept three
    /// kinds of match:
    ///   1. the full bundle ID — strictest, always safe;
    ///   2. the reverse-domain prefix with the last segment stripped if that
    ///      segment is generic (`.app`, `.mac`, …);
    ///   3. the last segment alone, *only* if it is long and non-generic, so
    ///      vendor-specific group containers that drop the reverse domain
    ///      (e.g. just `<TeamID>.Widget`) are still discovered.
    func groupContainerPaths() -> [URL] {
        let root = groupContainerSearchRoot
        guard let contents = try? FileManager.default.contentsOfDirectory(at: root, includingPropertiesForKeys: nil) else {
            return []
        }
        let matchPrefix = Self.identifyingPrefix(for: bundleID)
        let matchSuffix = Self.identifyingSuffix(for: bundleID)
        return contents.filter { url in
            let name = url.lastPathComponent
            if name.contains(bundleID) { return true }
            if let prefix = matchPrefix, name.contains(prefix) { return true }
            if let suffix = matchSuffix, name.contains(suffix) { return true }
            return false
        }
    }

    /// Reverse-domain prefix used for fuzzy group-container matching. Strips
    /// generic last segments (`.app`, `.mac`, …) and very short segments where
    /// substring matching would be too permissive. Returns `nil` if the result
    /// would be too short to identify a vendor uniquely.
    static func identifyingPrefix(for bundleID: String) -> String? {
        let segments = bundleID.split(separator: ".").map(String.init)
        guard segments.count >= 2 else { return nil }
        let last = segments.last ?? ""
        let lastIsGeneric = genericLastSegments.contains(last.lowercased()) || last.count <= 3
        let prefixSegments = lastIsGeneric ? Array(segments.dropLast()) : segments
        let prefix = prefixSegments.joined(separator: ".")
        // Below five characters we'd match on something like "com.x" which
        // would still collide with most reverse-domain identifiers.
        return prefix.count >= 5 ? prefix : nil
    }

    /// Last-segment fallback used when a group container is named with just an
    /// app-specific token (e.g. `<TeamID>.Widget` without the reverse domain).
    /// Returns the last segment only if it is long enough (≥6 chars) and not
    /// in the generic blocklist — anything shorter would collide too easily
    /// with unrelated vendors (e.g. `.app` hitting `apple`).
    static func identifyingSuffix(for bundleID: String) -> String? {
        let segments = bundleID.split(separator: ".").map(String.init)
        guard let last = segments.last, segments.count >= 2 else { return nil }
        if genericLastSegments.contains(last.lowercased()) { return nil }
        return last.count >= 6 ? last : nil
    }

    func existingPaths() -> [URL] {
        let all = candidatePaths() + groupContainerPaths()
        return all.filter { FileManager.default.fileExists(atPath: $0.path) }
    }
}
