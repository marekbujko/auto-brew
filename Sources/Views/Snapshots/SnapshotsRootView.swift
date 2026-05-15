import SwiftUI

struct SnapshotsRootView: View {
    @State private var store = SnapshotsStore.shared
    @State private var selected: AppSnapshot?

    var body: some View {
        NavigationSplitView {
            SnapshotListView(selection: $selected, store: store)
                .frame(minWidth: 280)
        } detail: {
            if let snap = selected {
                SnapshotDetailView(snapshot: snap)
            } else {
                ContentUnavailableView(
                    String(localized: "No snapshot selected"),
                    systemImage: "camera",
                    description: Text(String(localized: "Create a snapshot from the Installed tab."))
                )
            }
        }
        .task { store.refresh() }
    }
}
