import SwiftUI

struct DiscoverView: View {
    @Bindable var store: CatalogStore
    let onSelect: (CaskCatalogEntry) -> Void

    private let categoriesToShow: [BrowseCategory] = [
        .developerTools, .productivity, .browsers, .communication, .media
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                DiscoverSection(
                    title: String(localized: "Top Installed"),
                    entries: topInstalled,
                    onSelect: onSelect
                )

                ForEach(categoriesToShow) { cat in
                    DiscoverSection(
                        title: cat.displayName,
                        entries: top(for: cat),
                        onSelect: onSelect
                    )
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
    }

    private var topInstalled: [CaskCatalogEntry] {
        Array(store.allCasks.sorted {
            (store.analytics?.installCount(for: $0.token) ?? 0) >
            (store.analytics?.installCount(for: $1.token) ?? 0)
        }.prefix(6))
    }

    private func top(for cat: BrowseCategory) -> [CaskCatalogEntry] {
        Array(store.allCasks
            .filter { cat.matches($0) }
            .sorted {
                (store.analytics?.installCount(for: $0.token) ?? 0) >
                (store.analytics?.installCount(for: $1.token) ?? 0)
            }
            .prefix(6))
    }
}
