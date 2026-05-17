import SwiftUI

struct CategoryListView: View {
    let category: BrowseCategory
    @Bindable var store: CatalogStore
    @Binding var searchText: String

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(Array(filtered.enumerated()), id: \.element.id) { index, entry in
                    NavigationLink(value: entry) {
                        RankedCaskRow(rank: index + 1, entry: entry)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .navigationDestination(for: CaskCatalogEntry.self) { entry in
            BrowseDetailView(entry: entry)
        }
    }

    private var filtered: [CaskCatalogEntry] {
        let q = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        let base = q.isEmpty
            ? store.allCasks.filter { category.matches($0) }
            : store.allCasks.filter { entry in
                category.matches(entry) && (
                    entry.token.lowercased().contains(q) ||
                    entry.displayName.lowercased().contains(q) ||
                    (entry.description?.lowercased().contains(q) ?? false)
                )
            }
        return base.sorted {
            (store.analytics?.installCount(for: $0.token) ?? 0) >
            (store.analytics?.installCount(for: $1.token) ?? 0)
        }
    }
}
