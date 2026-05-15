import SwiftUI

struct SnapshotDetailView: View {
    let snapshot: AppSnapshot
    @State private var showRestoreConfirm = false
    @State private var showDeleteConfirm = false
    @State private var terminateApp = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(snapshot.displayName).font(.title2).bold()
                Text(snapshot.bundleID).font(.caption).monospaced().foregroundStyle(.secondary)
                Divider()
                LabeledContent(String(localized: "Created"), value: snapshot.createdAt.formatted(date: .complete, time: .standard))
                if let version = snapshot.sourceAppVersion {
                    LabeledContent(String(localized: "App Version"), value: version)
                }
                if let token = snapshot.caskToken {
                    LabeledContent(String(localized: "Cask Token"), value: token)
                }
                LabeledContent(String(localized: "Size"), value: ByteFormatter.string(snapshot.totalBytes))
                LabeledContent(String(localized: "Location"), value: snapshot.bundleURL.path)

                Divider()
                Toggle(String(localized: "Quit app before restore"), isOn: $terminateApp)
                HStack {
                    Button {
                        showRestoreConfirm = true
                    } label: { Label(String(localized: "Restore"), systemImage: "arrow.uturn.backward.circle.fill") }
                        .buttonStyle(.borderedProminent)
                    Button(role: .destructive) {
                        showDeleteConfirm = true
                    } label: { Label(String(localized: "Delete"), systemImage: "trash") }
                }
            }
            .padding()
        }
        .confirmationDialog(
            String(localized: "Restore snapshot for \(snapshot.displayName)?"),
            isPresented: $showRestoreConfirm
        ) {
            Button(String(localized: "Restore"), role: .destructive) {
                Task { await SnapshotsStore.shared.restore(snapshot, terminateApp: terminateApp) }
            }
        } message: {
            Text(String(localized: "This will overwrite the app's current preferences and data."))
        }
        .confirmationDialog(
            String(localized: "Delete snapshot?"),
            isPresented: $showDeleteConfirm
        ) {
            Button(String(localized: "Delete"), role: .destructive) {
                SnapshotsStore.shared.delete(snapshot)
            }
        }
    }
}
