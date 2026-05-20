import Foundation

/// Maps app bundle names (e.g. `Firefox.app`) to their cask token. Lookup is
/// case-insensitive because catalog and on-disk spellings drift
/// (`VSCode.app` vs. `Visual Studio Code.app`).
///
/// When multiple casks share the same `appName` (Homebrew often ships
/// `alfred`, `alfred@4`, `alfred@prerelease` — all installing `Alfred.app`),
/// the default cask (token without `@`) wins. Otherwise the `Installed`
/// list would randomly tag an app with a beta/legacy variant and the
/// resulting `brew upgrade` / `brew uninstall` call would fail because that
/// specific cask isn't the one Homebrew tracks.
struct CaskNameResolver: Sendable {
    private let appNameToToken: [String: String]

    init(catalog: [CaskCatalogEntry]) {
        var map: [String: String] = [:]

        // First pass: default casks only (no `@variant` suffix).
        for entry in catalog where !entry.token.contains("@") {
            for appName in entry.appNames {
                map[appName.lowercased()] = entry.token
            }
        }

        // Second pass: variants fill in only when no default matched —
        // that covers the rare case where Homebrew ships an app exclusively
        // as a `@variant` (e.g. a beta-only cask without a stable sibling).
        for entry in catalog where entry.token.contains("@") {
            for appName in entry.appNames {
                let key = appName.lowercased()
                if map[key] == nil {
                    map[key] = entry.token
                }
            }
        }

        self.appNameToToken = map
    }

    func token(forAppName name: String) -> String? {
        appNameToToken[name.lowercased()]
    }
}
