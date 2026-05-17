import SwiftUI

struct BrewStoreSidebar: View {
    @Binding var selection: BrewStoreSection
    @Binding var searchText: String

    private let contentCategories: [BrowseCategory] = [
        .browsers, .developerTools, .communication, .productivity,
        .media, .graphics, .utilities, .security, .games, .storage
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField(String(localized: "Search"), text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding(8)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 12)
            .padding(.top, 8)

            List(selection: Binding(
                get: { Optional(selection) },
                set: { if let new = $0 { selection = new } }
            )) {
                Section {
                    Label(String(localized: "Discover"), systemImage: "star.fill")
                        .tag(BrewStoreSection.discover)
                    Label(String(localized: "Installed"), systemImage: "shippingbox.fill")
                        .tag(BrewStoreSection.installed)
                    Label(String(localized: "Snapshots"), systemImage: "camera.on.rectangle.fill")
                        .tag(BrewStoreSection.snapshots)
                    Label(String(localized: "Updates"), systemImage: "arrow.triangle.2.circlepath")
                        .tag(BrewStoreSection.updates)
                }
                Section(String(localized: "Categories")) {
                    ForEach(contentCategories) { cat in
                        Label(cat.displayName, systemImage: cat.systemImage)
                            .tag(BrewStoreSection.category(cat))
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}
