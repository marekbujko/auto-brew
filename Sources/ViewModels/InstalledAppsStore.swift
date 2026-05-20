import Foundation

/// Lists the apps discovered in `/Applications` (plus `~/Applications`),
/// reconciled against `brew info --cask --json=v2 --installed`. Every row
/// only carries a cask token when Homebrew actually tracks the app — even
/// when the cask comes from a custom tap that the public catalog doesn't
/// list. Manually installed apps lose their tentative token so the UI
/// never offers brew actions that are guaranteed to fail.
@Observable
@MainActor
final class InstalledAppsStore {
    static let shared = InstalledAppsStore()

    private(set) var apps: [InstalledApp] = []
    private(set) var isLoading = false
    var searchQuery: String = ""

    /// Refresh-generation counter; ignored writes from stale concurrent
    /// refreshes so a slow brew call can't clobber a newer scan.
    private var refreshGeneration: UInt64 = 0

    var filtered: [InstalledApp] {
        let q = searchQuery.trimmingCharacters(in: .whitespaces).lowercased()
        if q.isEmpty { return apps }
        return apps.filter {
            $0.displayName.lowercased().contains(q) ||
            $0.bundleID.lowercased().contains(q) ||
            ($0.caskToken?.lowercased().contains(q) ?? false)
        }
    }

    func refresh() async {
        refreshGeneration &+= 1
        let generation = refreshGeneration
        isLoading = true
        defer {
            if generation == refreshGeneration { isLoading = false }
        }

        if BrewCatalogService.shared.casks.isEmpty {
            try? await BrewCatalogService.shared.loadCache()
        }
        // First-launch fallback: if the cache was empty too, fetch the
        // catalog so the resolver has something to work with.
        if BrewCatalogService.shared.casks.isEmpty {
            try? await BrewCatalogService.shared.refresh()
        }

        let catalog = BrewCatalogService.shared.casks
        let resolver = CaskNameResolver(catalog: catalog)
        let scanned = await AppDiscoveryService().scan(resolver: resolver)

        // Authoritative truth from brew, including custom taps.
        let installedCasks = await fetchInstalledCasks()
        let reconciled = reconcile(scanned, installedCasks: installedCasks)

        guard generation == refreshGeneration else { return }
        apps = reconciled
    }

    // MARK: - Reconciliation

    /// Resolver returns a *tentative* catalog token. Cross-check against the
    /// actual installed-cask metadata so the UI only exposes brew actions
    /// when brew can really act on them.
    private func reconcile(
        _ scanned: [InstalledApp],
        installedCasks: [InstalledCaskInfo]
    ) -> [InstalledApp] {
        let tokensInstalled = Set(installedCasks.map { $0.token.lowercased() })

        // App-file -> sorted list of installed tokens that ship that app.
        // Sort makes the eventual selection deterministic when several
        // installed casks ship the same .app bundle (rare but possible
        // when a user has multiple variants installed side by side).
        var artifactIndex: [String: [String]] = [:]
        for info in installedCasks {
            for appName in info.appNames {
                let key = appName.lowercased()
                artifactIndex[key, default: []].append(info.token)
            }
        }
        for key in artifactIndex.keys {
            artifactIndex[key]?.sort {
                // Default tokens (no `@`) win over variants — keeps the
                // choice stable and matches the resolver's preference.
                let aIsVariant = $0.contains("@")
                let bIsVariant = $1.contains("@")
                if aIsVariant != bIsVariant { return !aIsVariant }
                return $0 < $1
            }
        }

        return scanned.map { app -> InstalledApp in
            let appFileLower = app.appPath.lastPathComponent.lowercased()
            let finalToken: String?

            if let tentative = app.caskToken,
               tokensInstalled.contains(tentative.lowercased()) {
                // Resolver's catalog guess matches what brew tracks.
                finalToken = tentative
            } else if let candidates = artifactIndex[appFileLower],
                      let firstByPriority = candidates.first {
                // Brew tracks a cask that ships this .app — covers both
                // variant overrides and custom-tap installs that the
                // public catalog can't see.
                finalToken = firstByPriority
            } else {
                finalToken = nil
            }

            return InstalledApp(
                bundleID: app.bundleID,
                displayName: app.displayName,
                appPath: app.appPath,
                version: app.version,
                caskToken: finalToken
            )
        }
    }

    // MARK: - Brew metadata

    private struct InstalledCaskInfo: Sendable {
        let token: String
        let appNames: [String]
    }

    /// Calls `brew info --cask --json=v2 --installed` once. Returns the full
    /// token (which may include a tap prefix for custom-tap casks) plus the
    /// `.app` artifact names brew records for each installed cask. Failures
    /// are swallowed — an empty list means every app falls back to
    /// "unmanaged", which is the safe default.
    private func fetchInstalledCasks() async -> [InstalledCaskInfo] {
        guard let brew = BrewManager.shared.brewExecutable,
              let path = BrewManager.shared.brewPath else { return [] }
        guard let result = try? await BrewProcess.run(
            executable: brew,
            arguments: ["info", "--cask", "--json=v2", "--installed"],
            brewPath: path
        ), result.succeeded else { return [] }
        guard let data = result.stdout.data(using: .utf8) else { return [] }

        struct Payload: Decodable {
            struct Cask: Decodable {
                let token: String
                let full_token: String?
                let artifacts: [Artifact]?
            }
            // Artifacts are a heterogeneous array — only the `app` entries
            // carry `.app` bundle names. Decode lenient and extract those.
            struct Artifact: Decodable {
                let app: [String]?
                init(from decoder: Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let dict = try? container.decode([String: [String]].self) {
                        self.app = dict["app"]
                    } else {
                        self.app = nil
                    }
                }
            }
            let casks: [Cask]
        }

        guard let payload = try? JSONDecoder().decode(Payload.self, from: data) else { return [] }
        return payload.casks.map { cask in
            InstalledCaskInfo(
                token: cask.full_token ?? cask.token,
                appNames: (cask.artifacts ?? []).flatMap { $0.app ?? [] }
            )
        }
    }
}
