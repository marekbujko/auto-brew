import SwiftUI

/// Detail sheet for a single cask. Drives installation through `BrewInstaller`
/// and triggers an `InstalledAppsStore.refresh()` afterwards so Discover/Browse
/// rows immediately flip from Install to Open. Errors surface in an alert
/// rather than inline so the layout doesn't jump.
struct BrowseDetailView: View {
    let entry: CaskCatalogEntry
    @State private var isInstalling = false
    @State private var installError: String?
    @State private var showPolicySheet = false
    @State private var settings = SettingsStore.shared
    @State private var sizes = CaskSizeService.shared

    private var hasOverride: Bool {
        settings.packageOverrides.contains { $0.token == entry.token && !$0.isEmpty }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 14) {
                    CaskIconView(token: entry.token,
                                 appNames: entry.appNames,
                                 displayName: entry.displayName,
                                 homepage: entry.homepage,
                                 size: 64)
                    VStack(alignment: .leading) {
                        Text(entry.presentationName).font(.title2).bold()
                        Text(entry.token).font(.caption).foregroundStyle(.secondary).monospaced()
                        Text(String(localized: "Version: \(entry.version)")).font(.caption)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 6) {
                        installButton
                        Button {
                            showPolicySheet = true
                        } label: {
                            Label(
                                hasOverride
                                    ? String(localized: "Update Policy (custom)")
                                    : String(localized: "Update Policy"),
                                systemImage: "slider.horizontal.3"
                            )
                            .font(.caption)
                        }
                        .buttonStyle(.borderless)
                    }
                }
                Divider()
                downloadSizeRow
                if let desc = entry.description {
                    Text(desc).font(.body)
                }
                if !entry.homepage.isEmpty, let url = URL(string: entry.homepage) {
                    Link(entry.homepage, destination: url).font(.callout)
                }
                if !entry.appNames.isEmpty {
                    Text(String(localized: "Installed apps:")).font(.headline).padding(.top, 8)
                    ForEach(entry.appNames, id: \.self) { name in
                        Label(name, systemImage: "app").font(.callout)
                    }
                }
            }
            .padding()
        }
        .alert(String(localized: "Install failed"),
               isPresented: Binding(get: { installError != nil }, set: { if !$0 { installError = nil } }),
               presenting: installError) { _ in
            Button("OK") { installError = nil }
        } message: { msg in Text(msg) }
        .sheet(isPresented: $showPolicySheet) {
            PackagePolicyOverrideSheet(token: entry.token, displayName: entry.presentationName)
        }
        .task(id: entry.token) {
            guard let url = URL(string: entry.url) else { return }
            await sizes.prefetch(token: entry.token, url: url)
        }
    }

    /// Honest "we don't know" footer when the catalog URL is missing,
    /// the HEAD fails, or the server hides Content-Length. Never gates
    /// the Install button.
    @ViewBuilder
    private var downloadSizeRow: some View {
        HStack(spacing: 6) {
            Image(systemName: "internaldrive")
                .foregroundStyle(.secondary)
            if let bytes = sizes.size(for: entry.token) {
                Text(String(localized: "Download size: \(ByteFormatter.string(bytes))"))
            } else if sizes.isFetching(entry.token) {
                Text(String(localized: "Checking download size…"))
                    .foregroundStyle(.secondary)
                ProgressView().controlSize(.mini)
            } else {
                Text(String(localized: "Download size unknown"))
                    .foregroundStyle(.tertiary)
            }
            Spacer()
        }
        .font(.caption)
    }

    @ViewBuilder
    private var installButton: some View {
        Button {
            Task { await install() }
        } label: {
            if isInstalling {
                ProgressView().controlSize(.small)
            } else {
                Label(String(localized: "Install"), systemImage: "arrow.down.circle.fill")
            }
        }
        .adaptiveProminentButtonStyle()
        .disabled(isInstalling)
    }

    @MainActor
    private func install() async {
        isInstalling = true
        defer { isInstalling = false }
        do {
            try await BrewInstaller().install(token: entry.token)
            await InstalledAppsStore.shared.refresh()
        } catch {
            installError = error.localizedDescription
        }
    }
}
