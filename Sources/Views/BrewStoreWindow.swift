import SwiftUI

enum BrewStoreTab: String, CaseIterable, Identifiable {
    case browse, installed, snapshots
    var id: String { rawValue }
    var label: String {
        switch self {
        case .browse: String(localized: "Browse")
        case .installed: String(localized: "Installed")
        case .snapshots: String(localized: "Snapshots")
        }
    }
    var systemImage: String {
        switch self {
        case .browse: "magnifyingglass"
        case .installed: "shippingbox"
        case .snapshots: "camera.on.rectangle"
        }
    }
}

struct BrewStoreWindow: View {
    @State private var selectedTab: BrewStoreTab = .browse

    var body: some View {
        TabView(selection: $selectedTab) {
            BrowseRootView()
                .tabItem { Label(BrewStoreTab.browse.label, systemImage: BrewStoreTab.browse.systemImage) }
                .tag(BrewStoreTab.browse)

            InstalledAppsView()
                .tabItem { Label(BrewStoreTab.installed.label, systemImage: BrewStoreTab.installed.systemImage) }
                .tag(BrewStoreTab.installed)

            SnapshotsRootView()
                .tabItem { Label(BrewStoreTab.snapshots.label, systemImage: BrewStoreTab.snapshots.systemImage) }
                .tag(BrewStoreTab.snapshots)
        }
        .frame(minWidth: 900, minHeight: 600)
    }
}
