import Foundation

/// Lists the apps discovered in `/Applications`, reconciled against
/// `brew list --cask` so each row only carries a cask token when Homebrew
/// actually tracks that app. Without the reconciliation, the catalog-only
/// resolver would tag manually installed apps with a tentative token and
/// the resulting `brew upgrade` / `brew uninstall` would fail with
/// `Cask 'X' is not installed.`
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

    /// Rescan `/Applications` and reconcile against `brew list --cask`. The
    /// catalog is warmed on demand because the menu bar may be opened before
    /// BrewStore has ever loaded the cache.
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
        // First-launch fallback: if cache was empty too, try a network fetch
        // so Homebrew-managed apps get their cask token immediately.
        if BrewCatalogService.shared.casks.isEmpty {
            try? await BrewCatalogService.shared.refresh()
        }

        let catalog = BrewCatalogService.shared.casks
        let resolver = CaskNameResolver(catalog: catalog)
        let scanned = await AppDiscoveryService().scan(resolver: resolver)

        // Authoritative truth: what brew thinks is installed right now.
        let installedTokens = await fetchInstalledCaskTokens()
        let reconciled = reconcile(scanned, against: installedTokens, catalog: catalog)

        // Drop the result if a newer refresh started while we were waiting
        // on brew — otherwise a slow run would overwrite a more recent one.
        guard generation == refreshGeneration else { return }
        apps = reconciled
    }

    // MARK: - Reconciliation

    /// Resolver returns a *tentative* token derived from the public catalog.
    /// Cross-check it against `installedTokens` so we never offer brew
    /// actions for apps that brew doesn't actually track.
    private func reconcile(
        _ scanned: [InstalledApp],
        against installedTokens: Set<String>,
        catalog: [CaskCatalogEntry]
    ) -> [InstalledApp] {
        // Token → catalog entry, lowercased for safe membership checks.
        let catalogByToken: [String: CaskCatalogEntry] = catalog.reduce(into: [:]) {
            $0[$1.token.lowercased()] = $1
        }

        return scanned.map { app -> InstalledApp in
            let appFile = app.appPath.lastPathComponent
            let finalToken = resolveAuthoritativeToken(
                tentative: app.caskToken,
                appFile: appFile,
                installedTokens: installedTokens,
                catalogByToken: catalogByToken
            )
            return InstalledApp(
                bundleID: app.bundleID,
                displayName: app.displayName,
                appPath: app.appPath,
                version: app.version,
                caskToken: finalToken,
                isHomebrewManaged: finalToken != nil
            )
        }
    }

    private func resolveAuthoritativeToken(
        tentative: String?,
        appFile: String,
        installedTokens: Set<String>,
        catalogByToken: [String: CaskCatalogEntry]
    ) -> String? {
        // Fast path: tentative token from the resolver matches what brew has.
        if let tentative, installedTokens.contains(tentative.lowercased()) {
            return tentative
        }

        // Variant override / wrong-default case: brew tracks a different
        // cask whose catalog entry installs the same `.app` bundle. Walk the
        // installed set and pick the first match.
        let appFileLower = appFile.lowercased()
        for installed in installedTokens {
            guard let entry = catalogByToken[installed] else { continue }
            if entry.appNames.contains(where: { $0.lowercased() == appFileLower }) {
                return entry.token
            }
        }

        // Not tracked by brew — drop the tentative token so the UI doesn't
        // expose Upgrade/Uninstall actions that are guaranteed to fail.
        return nil
    }

    /// Shells out to `brew list --cask` once per refresh and returns the
    /// lowercased token set. Failures (brew missing, command error) are
    /// swallowed — an empty set just means every app falls back to
    /// "unmanaged", which is the safe default.
    private func fetchInstalledCaskTokens() async -> Set<String> {
        guard let brew = BrewManager.shared.brewExecutable,
              let path = BrewManager.shared.brewPath else { return [] }
        guard let result = try? await BrewProcess.run(
            executable: brew,
            arguments: ["list", "--cask"],
            brewPath: path
        ), result.succeeded else { return [] }

        return Set(
            result.stdout
                .split(whereSeparator: { $0.isWhitespace })
                .map { $0.lowercased() }
        )
    }
}
