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

    /// Group containers often have cryptic prefixes (e.g. `ABCDE12345.com.app`),
    /// so we substring-match on the bundle ID or its last component. False
    /// positives are fine — better to back up one extra than lose user data.
    func groupContainerPaths() -> [URL] {
        let root = groupContainerSearchRoot
        guard let contents = try? FileManager.default.contentsOfDirectory(at: root, includingPropertiesForKeys: nil) else {
            return []
        }
        return contents.filter { url in
            let name = url.lastPathComponent
            return name.contains(bundleID) ||
                   (bundleID.split(separator: ".").last.map { name.contains(String($0)) } ?? false)
        }
    }

    func existingPaths() -> [URL] {
        let all = candidatePaths() + groupContainerPaths()
        return all.filter { FileManager.default.fileExists(atPath: $0.path) }
    }
}
