import SwiftUI
import AppKit

/// Snapshots tab: list on the left, detail on the right. A nested
/// `NavigationSplitView` was tried first but the parent `BrewStoreWindow`
/// already supplies one, and nesting two of them strips sidebar styling.
/// `HSplitView` was tried next but it ignores `idealWidth` hints and lands
/// on a 50/50 split that wastes space and renders two side-by-side empty
/// states. A plain `HStack` with a fixed-width list and a flexible detail
/// is the cleanest fit — and when no snapshots exist at all, we collapse
/// the split entirely and show a single centered empty state across the
/// whole pane.
struct SnapshotsRootView: View {
    @State private var store = SnapshotsStore.shared
    @State private var selected: AppSnapshot?
    @State private var showWizard = false
    @State private var exportError: String?

    var body: some View {
        Group {
            if store.snapshots.isEmpty {
                ContentUnavailableView(
                    String(localized: "No snapshots yet"),
                    systemImage: "camera",
                    description: Text(String(localized: "Create a snapshot from the Installed tab."))
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                HStack(spacing: 0) {
                    SnapshotListView(selection: $selected, store: store)
                        .frame(width: 280)
                    Divider()
                    Group {
                        if let snap = selected {
                            SnapshotDetailView(snapshot: snap)
                        } else {
                            ContentUnavailableView(
                                String(localized: "No snapshot selected"),
                                systemImage: "camera",
                                description: Text(String(localized: "Pick a snapshot from the list to see its details."))
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .task { store.refresh() }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showWizard = true
                } label: {
                    Label(String(localized: "Import Bundle"), systemImage: "tray.and.arrow.down")
                }
            }
            ToolbarItem(placement: .secondaryAction) {
                Button {
                    Task { await exportAll() }
                } label: {
                    Label(String(localized: "Export All…"), systemImage: "square.and.arrow.up.on.square")
                }
                .disabled(store.snapshots.isEmpty)
            }
        }
        .sheet(isPresented: $showWizard) {
            RestoreWizardView(onClose: {
                showWizard = false
                store.refresh()
            })
        }
        .alert(String(localized: "Export failed"),
               isPresented: Binding(get: { exportError != nil }, set: { if !$0 { exportError = nil } }),
               presenting: exportError) { _ in
            Button("OK") { exportError = nil }
        } message: { msg in
            Text(msg)
        }
    }

    /// Bundles every snapshot into a single `.autobrewbundle` folder. The
    /// timestamp in the name prevents collisions when the same destination is
    /// picked twice.
    @MainActor
    private func exportAll() async {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.title = String(localized: "Choose folder for export")
        let resp = await panel.runModalAsync()
        guard resp == .OK, let dir = panel.url else { return }
        let stamp = Date().formatted(.iso8601.year().month().day().time(includingFractionalSeconds: false).timeSeparator(.omitted))
        let target = dir.appendingPathComponent("AutoBrew-export-\(stamp).autobrewbundle", isDirectory: true)
        do {
            try await SnapshotService.shared.exportRestoreList(snapshots: store.snapshots, to: target)
        } catch {
            exportError = error.localizedDescription
        }
    }
}
