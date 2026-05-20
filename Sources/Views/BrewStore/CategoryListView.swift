import SwiftUI

/// Filtered "all casks in this category" list, sorted by install popularity.
/// Detail opens in a sheet rather than pushing — keeps the BrewStore window
/// chrome stable while users browse.
///
/// Global search is handled by `SearchResultsView` in
/// `BrewStoreWindow.detailView`; once a non-empty query is in the sidebar
/// field, this view is no longer rendered. That's why there's no search
/// filter inside the category list itself — it would be unreachable.
struct CategoryListView: View {
    let category: BrowseCategory
    @Bindable var store: CatalogStore

    @State private var selectedEntry: CaskCatalogEntry?

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(Array(ranked.enumerated()), id: \.element.id) { index, entry in
                    RankedCaskRow(rank: index + 1, entry: entry, onOpenDetail: { selectedEntry = entry })
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
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

    /// Category filter, then sorted by Homebrew install popularity.
    private var ranked: [CaskCatalogEntry] {
        store.allCasks
            .filter { category.matches($0) }
            .sorted {
                (store.analytics?.installCount(for: $0.token) ?? 0) >
                (store.analytics?.installCount(for: $1.token) ?? 0)
            }
    }
}
