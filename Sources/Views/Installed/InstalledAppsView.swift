import SwiftUI

struct InstalledAppsView: View {
    @State private var store = InstalledAppsStore.shared
    @State private var snapshotTarget: InstalledApp?
    @State private var operationError: String?

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField(String(localized: "Filter…"), text: $store.searchQuery)
                    .textFieldStyle(.roundedBorder)
                Button {
                    Task { await store.refresh() }
                } label: { Label(String(localized: "Refresh"), systemImage: "arrow.clockwise") }
                .disabled(store.isLoading)
            }
            .padding(8)

            if store.apps.isEmpty && !store.isLoading {
                ContentUnavailableView(
                    String(localized: "No apps found"),
                    systemImage: "shippingbox",
                    description: Text(String(localized: "Refresh to scan /Applications."))
                )
            } else {
                List(store.filtered) { app in
                    InstalledAppRowView(
                        app: app,
                        onUpgrade: {
                            guard let token = app.caskToken else { return }
                            Task {
                                do {
                                    try await BrewInstaller().upgrade(token: token)
                                    await store.refresh()
                                } catch {
                                    operationError = error.localizedDescription
                                }
                            }
                        },
                        onUninstall: {
                            guard let token = app.caskToken else { return }
                            Task {
                                do {
                                    try await BrewInstaller().uninstall(token: token)
                                    await store.refresh()
                                } catch {
                                    operationError = error.localizedDescription
                                }
                            }
                        },
                        onSnapshot: { snapshotTarget = app }
                    )
                }
            }
        }
        .task { await store.refresh() }
        .sheet(item: $snapshotTarget) { app in
            // Wird in Phase 4.7 ersetzt durch NewSnapshotView:
            VStack(spacing: 16) {
                Text(String(localized: "Snapshot for \(app.displayName)")).font(.title2)
                Button(String(localized: "Close")) { snapshotTarget = nil }
            }
            .padding(30)
            .frame(width: 360)
        }
        .alert(String(localized: "Operation failed"),
               isPresented: Binding(get: { operationError != nil },
                                    set: { if !$0 { operationError = nil } }),
               presenting: operationError) { _ in
            Button("OK") { operationError = nil }
        } message: { msg in Text(msg) }
    }
}
