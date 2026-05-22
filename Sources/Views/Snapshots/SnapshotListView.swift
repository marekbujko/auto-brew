import SwiftUI

/// Sidebar list grouped by bundle ID — one section per app, snapshots inside
/// sorted by the store. Selection is driven from `SnapshotsRootView`. The
/// explicit `.sidebar` list style is required because this list lives inside
/// an `HSplitView`, not a `NavigationSplitView` sidebar slot — without it the
/// rows render as plain text against the dark background and become invisible.
struct SnapshotListView: View {
    @Binding var selection: AppSnapshot?
    @Bindable var store: SnapshotsStore

    var body: some View {
        Group {
            if store.snapshots.isEmpty {
                ContentUnavailableView(
                    String(localized: "No snapshots yet"),
                    systemImage: "camera",
                    description: Text(String(localized: "Create one from the Installed tab."))
                )
            } else {
                List(selection: $selection) {
                    ForEach(store.groupedByApp, id: \.bundleID) { group in
                        Section(group.items.first?.displayName ?? group.bundleID) {
                            ForEach(group.items) { snap in
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(snap.createdAt.formatted(date: .abbreviated, time: .shortened))
                                        .font(.callout)
                                    Text(ByteFormatter.string(snap.totalBytes))
                                        .font(.caption2).foregroundStyle(.secondary)
                                }
                                .tag(snap)
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
            }
        }
        .frame(maxHeight: .infinity)
    }
}
