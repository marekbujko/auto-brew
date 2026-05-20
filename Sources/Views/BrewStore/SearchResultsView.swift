import SwiftUI

/// Global search across the whole cask catalog — replaces the section detail
/// while the search field has a query. Mirrors the layout of
/// `CategoryListView` (RankedCaskRow + detail sheet) so the visual jump
/// when search activates is minimal.
struct SearchResultsView: View {
    @Bindable var store: CatalogStore
    let query: String

    @State private var selectedEntry: CaskCatalogEntry?

    var body: some View {
        Group {
            if results.isEmpty {
                ContentUnavailableView.search(text: query)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(results.enumerated()), id: \.element.id) { index, entry in
                            RankedCaskRow(rank: index + 1, entry: entry, onOpenDetail: { selectedEntry = entry })
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                }
            }
        }
        .sheet(item: $selectedEntry) { entry in
            NavigationStack {
                BrowseDetailView(entry: entry)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(String(localized: "Close")) { selectedEntry = nil }
                        }
                    }
                    .frame(minWidth: 520, minHeight: 420)
            }
        }
    }

    /// Substring match on token / displayName / presentationName / description,
    /// sorted by Homebrew install popularity so the most relevant hits land
    /// at the top.
    private var results: [CaskCatalogEntry] {
        let q = query.trimmingCharacters(in: .whitespaces).lowercased()
        guard !q.isEmpty else { return [] }
        return store.allCasks
            .filter { entry in
                entry.token.lowercased().contains(q) ||
                entry.displayName.lowercased().contains(q) ||
                entry.presentationName.lowercased().contains(q) ||
                (entry.description?.lowercased().contains(q) ?? false)
            }
            .sorted {
                (store.analytics?.installCount(for: $0.token) ?? 0) >
                (store.analytics?.installCount(for: $1.token) ?? 0)
            }
    }
}
