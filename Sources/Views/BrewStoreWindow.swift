import SwiftUI

enum BrewStoreSection: Hashable {
    case discover
    case category(BrowseCategory)
    case installed
    case snapshots
    case updates
    case pendingApprovals
}

/// The standalone "BrewStore" window — a proper full-size browser for casks,
/// installed apps, snapshots and updates. Lives in its own `Window` scene
/// (see `AutoBrewApp`) because the menu-bar popover is far too small for the
/// split-view UI and gets dismissed on every outside click.
struct BrewStoreWindow: View {
    @State private var selection: BrewStoreSection = .discover
    @State private var catalog = CatalogStore.shared
    @State private var service = BrewCatalogService.shared
    @State private var searchText: String = ""
    @State private var detailEntry: CaskCatalogEntry?
    @State private var navigation = BrewStoreNavigation.shared

    var body: some View {
        NavigationSplitView {
            BrewStoreSidebar(selection: $selection, searchText: $searchText)
                .navigationSplitViewColumnWidth(min: 200, ideal: 220, max: 280)
        } detail: {
            detailView
                .navigationTitle(titleForSelection)
                .toolbarTitleDisplayMode(.inline)
        }
        .frame(minWidth: 980, minHeight: 640)
        .task {
            await loadCatalog()
            await InstalledAppsStore.shared.refresh()
        }
        .onAppear {
            consumeRequestedSection()
        }
        .onChange(of: navigation.requestedSection) { _, _ in
            consumeRequestedSection()
        }
        .sheet(item: $detailEntry) { entry in
            NavigationStack {
                BrowseDetailView(entry: entry)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(String(localized: "Close")) { detailEntry = nil }
                        }
                    }
                    .frame(minWidth: 520, minHeight: 420)
            }
        }
    }

    private var trimmedSearch: String {
        searchText.trimmingCharacters(in: .whitespaces)
    }

    private var isSearching: Bool { !trimmedSearch.isEmpty }

    @ViewBuilder
    private var detailView: some View {
        if isSearching {
            // Search hijacks the detail pane regardless of the selected
            // section — clearing the field returns the user to whatever
            // they were looking at before.
            SearchResultsView(store: catalog, query: trimmedSearch)
        } else {
            switch selection {
            case .discover:
                DiscoverView(store: catalog, onSelect: { detailEntry = $0 })
            case .category(let cat):
                CategoryListView(category: cat, store: catalog)
            case .installed:
                InstalledAppsView()
            case .snapshots:
                SnapshotsRootView()
            case .updates:
                UpdatesView()
            case .pendingApprovals:
                PendingApprovalsView()
            }
        }
    }

    private var titleForSelection: String {
        if isSearching {
            return String(localized: "Search: \(trimmedSearch)")
        }
        switch selection {
        case .discover: return String(localized: "Discover")
        case .category(let cat): return cat.displayName
        case .installed: return String(localized: "Installed")
        case .snapshots: return String(localized: "Snapshots")
        case .updates: return String(localized: "Updates")
        case .pendingApprovals: return String(localized: "Pending Approvals")
        }
    }

    /// Honours the most recent deep-link request once and clears it so a
    /// later manual selection from the sidebar isn't overridden.
    private func consumeRequestedSection() {
        if let requested = navigation.requestedSection {
            selection = requested
            navigation.requestedSection = nil
        }
    }

    /// Show cached data immediately, then refresh from the network if the
    /// cache is older than a day. The double `replaceAll` is intentional:
    /// users see something fast and the list updates in place once the
    /// fetch completes.
    private func loadCatalog() async {
        try? await service.loadCache()
        catalog.replaceAll(service.casks, analytics: service.analytics)
        let stale = service.lastRefresh.map { Date().timeIntervalSince($0) > 86_400 } ?? true
        if stale {
            try? await service.refresh()
            catalog.replaceAll(service.casks, analytics: service.analytics)
        }
    }
}
