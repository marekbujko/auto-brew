import Foundation
import AppKit

/// Scans `/Applications` and `~/Applications` and attaches a **tentative**
/// cask token to each entry if the public catalog lists a cask that ships
/// the same `.app` bundle. The token is catalog-derived only —
/// `InstalledAppsStore` reconciles it against the authoritative
/// `brew info --cask --json=v2 --installed` output before publishing, so
/// manually installed apps and custom-tap casks both get the right
/// treatment in the UI. Apple system apps are filtered out — otherwise
/// every preinstalled bundle would clutter the list.
struct AppDiscoveryService: Sendable {
    func scan(directories: [URL] = AppDiscoveryService.defaultDirectories,
              resolver: CaskNameResolver) async -> [InstalledApp] {
        var results: [InstalledApp] = []
        var seenBundleIDs = Set<String>()
        for dir in directories {
            guard let items = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else { continue }
            for item in items where item.pathExtension == "app" {
                guard let app = readApp(at: item) else { continue }
                if AppleAppFilter.isAppleSystemApp(bundleID: app.bundleID) { continue }
                // De-dup across directories — `/Applications` and
                // `~/Applications` can hold copies of the same app.
                guard seenBundleIDs.insert(app.bundleID).inserted else { continue }
                let token = resolver.token(forAppName: item.lastPathComponent)
                results.append(InstalledApp(
                    bundleID: app.bundleID,
                    displayName: app.displayName,
                    appPath: item,
                    version: app.version,
                    caskToken: token
                ))
            }
        }
        return results.sorted { $0.displayName.localizedCaseInsensitiveCompare($1.displayName) == .orderedAscending }
    }

    func readApp(at appURL: URL) -> InstalledApp? {
        let plistURL = appURL.appendingPathComponent("Contents/Info.plist")
        guard let data = try? Data(contentsOf: plistURL),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let bundleID = plist["CFBundleIdentifier"] as? String else {
            return nil
        }
        let name = (plist["CFBundleDisplayName"] as? String)
                ?? (plist["CFBundleName"] as? String)
                ?? appURL.deletingPathExtension().lastPathComponent
        let version = plist["CFBundleShortVersionString"] as? String
        return InstalledApp(
            bundleID: bundleID,
            displayName: name,
            appPath: appURL,
            version: version,
            caskToken: nil
        )
    }

    /// `/Applications` is the system-wide install location; `~/Applications`
    /// is the per-user fallback Homebrew uses when launched with
    /// `--appdir=~/Applications` or when the user doesn't have admin rights
    /// on the global folder.
    static var defaultDirectories: [URL] {
        var paths = [URL(fileURLWithPath: "/Applications")]
        let userApps = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Applications")
        if FileManager.default.fileExists(atPath: userApps.path) {
            paths.append(userApps)
        }
        return paths
    }
}
