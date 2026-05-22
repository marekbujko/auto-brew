import SwiftUI

/// Sidebar list grouped by bundle ID — one section per app, snapshots inside
/// sorted by the store. Selection is driven from `SnapshotsRootView`, which
/// only mounts this view when there is at least one snapshot, so the empty
/// state lives at the parent level instead of duplicating here.
///
/// The explicit `.sidebar` list style is required: the list lives inside a
/// plain `HStack`, not a `NavigationSplitView` sidebar slot, and without the
/// style the rows render as plain text against the dark background and
/// disappear visually.
struct SnapshotListView: View {
    @Binding var selection: AppSnapshot?
    @Bindable var store: SnapshotsStore

    var body: some View {
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
        .frame(maxHeight: .infinity)
    }
}
