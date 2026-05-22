import SwiftUI
import AppKit

/// Snapshots tab: split view with the snapshot list on the left and the
/// detail on the right. The Restore wizard is reachable from here (not the
/// Installed tab) because importing a bundle from another Mac conceptually
/// belongs to the snapshot library, even though no snapshot is selected yet.
///
/// Uses `HSplitView` rather than a nested `NavigationSplitView` — the parent
/// `BrewStoreWindow` already supplies one, and nesting them silently breaks
/// sidebar styling on the inner list so the rows render invisible against
/// the dark background.
struct SnapshotsRootView: View {
    @State private var store = SnapshotsStore.shared
    @State private var selected: AppSnapshot?
    @State private var showWizard = false
    @State private var exportError: String?

    var body: some View {
        HSplitView {
            SnapshotListView(selection: $selected, store: store)
                .frame(minWidth: 260, idealWidth: 300)
            Group {
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
            .frame(minWidth: 360)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
