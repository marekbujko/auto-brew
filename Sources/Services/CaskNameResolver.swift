import Foundation

/// Maps app bundle names (e.g. `Firefox.app`) to their cask token. Lookup is
/// case-insensitive because catalog and on-disk spellings drift
/// (`VSCode.app` vs. `Visual Studio Code.app`).
struct CaskNameResolver: Sendable {
    private let appNameToToken: [String: String]

    init(catalog: [CaskCatalogEntry]) {
        var map: [String: String] = [:]
        for entry in catalog {
            for appName in entry.appNames {
                map[appName.lowercased()] = entry.token
            }
        }
        self.appNameToToken = map
    }

    func token(forAppName name: String) -> String? {
        appNameToToken[name.lowercased()]
    }
}
