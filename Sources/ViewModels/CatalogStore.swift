import Foundation

/// Source of truth for the cask catalog shown in BrewStore. Holds the raw
/// catalog plus precomputed rankings so SwiftUI doesn't re-sort ~7000 entries
/// on every render.
@Observable
@MainActor
final class CatalogStore {
    static let shared = CatalogStore()

    var searchQuery: String = ""
    var sortMode: SortMode = .popularity
    private(set) var allCasks: [CaskCatalogEntry] = []
    private(set) var analytics: CaskAnalytics?

    /// Precomputed top-6 most-installed casks overall.
    /// Recomputed only when `replaceAll(...)` runs — avoids re-sorting ~7000 casks
    /// on every SwiftUI render of DiscoverView.
    private(set) var topInstalledOverall: [CaskCatalogEntry] = []

    /// Precomputed top-6 most-installed casks per browse category.
    /// Same rationale as `topInstalledOverall`.
    private(set) var topByCategory: [BrowseCategory: [CaskCatalogEntry]] = [:]

    /// Categories for which top-N rankings are precomputed in `recomputeRankings()`.
    private static let rankedCategories: [BrowseCategory] = [
        .browsers, .developerTools, .communication, .productivity,
        .media, .graphics, .utilities, .security, .games, .storage
    ]

    enum SortMode: String, CaseIterable, Sendable {
        case popularity, name, recent
    }

    var filtered: [CaskCatalogEntry] {
        let q = searchQuery.trimmingCharacters(in: .whitespaces).lowercased()
        let base: [CaskCatalogEntry]
        if q.isEmpty {
            base = allCasks
        } else {
            base = allCasks.filter { entry in
                entry.token.lowercased().contains(q) ||
                entry.displayName.lowercased().contains(q) ||
                (entry.description?.lowercased().contains(q) ?? false)
            }
        }
        switch sortMode {
        case .popularity:
            return base.sorted {
                (analytics?.installCount(for: $0.token) ?? 0) >
                (analytics?.installCount(for: $1.token) ?? 0)
            }
        case .name:
            return base.sorted { $0.displayName.localizedCaseInsensitiveCompare($1.displayName) == .orderedAscending }
        case .recent:
            // No "added at" field in formulae.brew.sh catalog yet — falls back to catalog order.
            return base
        }
    }

    /// Swap in a freshly-loaded catalog. Triggers a one-shot ranking pass so
    /// later reads of `topInstalledOverall`/`topByCategory` are O(1).
    func replaceAll(_ casks: [CaskCatalogEntry], analytics: CaskAnalytics?) {
        allCasks = casks
        self.analytics = analytics
        recomputeRankings()
    }

    private func recomputeRankings() {
        let sorted = allCasks.sorted {
            (analytics?.installCount(for: $0.token) ?? 0) >
            (analytics?.installCount(for: $1.token) ?? 0)
        }
        topInstalledOverall = Array(sorted.prefix(6))
        var byCat: [BrowseCategory: [CaskCatalogEntry]] = [:]
        for cat in Self.rankedCategories {
            byCat[cat] = Array(sorted.filter { cat.matches($0) }.prefix(6))
        }
        topByCategory = byCat
    }
}
