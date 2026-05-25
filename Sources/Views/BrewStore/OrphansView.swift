import SwiftUI

/// BrewStore section that surfaces the result of `brew autoremove
/// --dry-run` — formulae that were pulled in as dependencies but
/// whose parents are gone. Removing them is safe by definition;
/// nothing the user explicitly installed disappears.
struct OrphansView: View {
    @State private var manager = BrewManager.shared
    @State private var isRefreshing = false
    @State private var removalInProgress = false
    @State private var removalError: String?
    @State private var lastRemovalCount: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            Divider()
            if let lastRemovalCount {
                Label(String(localized: "Removed \(lastRemovalCount) orphaned formula(e). Disk space reclaimed."),
                      systemImage: "checkmark.seal.fill")
                    .foregroundStyle(.green)
                    .font(.callout)
                    .padding(.horizontal, 16)
            }
            content
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .task { await refreshIfNeeded() }
        .alert(String(localized: "Autoremove failed"),
               isPresented: Binding(get: { removalError != nil },
                                    set: { if !$0 { removalError = nil } }),
               presenting: removalError) { _ in
            Button("OK") { removalError = nil }
        } message: { msg in Text(msg) }
    }

    // MARK: - Subviews

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(String(localized: "Orphaned formulae"))
                    .font(.title2.bold())
                Text(String(localized: "Dependencies whose parents are gone. `brew autoremove` will drop them — your explicit installs are never touched."))
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            HStack(spacing: 6) {
                Button {
                    Task { await refresh(force: true) }
                } label: {
                    Label(String(localized: "Refresh"), systemImage: "arrow.clockwise")
                }
                .disabled(isRefreshing || removalInProgress)
                Button(role: .destructive) {
                    Task { await runAutoremove() }
                } label: {
                    if removalInProgress {
                        ProgressView().controlSize(.small)
                    } else {
                        Label(String(localized: "Remove All"), systemImage: "trash")
                    }
                }
                .disabled(manager.orphanedPackages.isEmpty || removalInProgress || isRefreshing)
                .adaptiveProminentButtonStyle()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    @ViewBuilder
    private var content: some View {
        if isRefreshing && manager.orphanedPackages.isEmpty {
            ContentUnavailableView {
                ProgressView()
            } description: {
                Text(String(localized: "Asking brew what's orphaned…"))
            }
        } else if manager.orphanedPackages.isEmpty {
            ContentUnavailableView(
                String(localized: "No orphaned formulae"),
                systemImage: "leaf.fill",
                description: Text(String(localized: "Every installed formula is still depended on. Nothing to reclaim."))
            )
        } else {
            List(manager.orphanedPackages) { package in
                HStack {
                    Image(systemName: "leaf")
                        .foregroundStyle(.secondary)
                    Text(package.name)
                        .font(.body.monospaced())
                    Spacer()
                }
            }
            .listStyle(.inset)
        }
    }

    // MARK: - Actions

    private func refreshIfNeeded() async {
        // Don't refetch on every section switch — but if the list is
        // empty we have nothing to show, so a quick call is worth it.
        if manager.orphanedPackages.isEmpty {
            await refresh(force: false)
        }
    }

    private func refresh(force: Bool) async {
        guard !isRefreshing else { return }
        isRefreshing = true
        defer { isRefreshing = false }
        lastRemovalCount = nil
        await manager.fetchOrphans()
    }

    private func runAutoremove() async {
        guard !removalInProgress else { return }
        removalInProgress = true
        defer { removalInProgress = false }
        let expected = manager.orphanedPackages.count
        do {
            _ = try await manager.runAutoremove()
            lastRemovalCount = expected
            // Refresh in case brew lifted further orphans now that
            // the first batch is gone (chain dependencies).
            await manager.fetchOrphans()
        } catch {
            removalError = error.localizedDescription
        }
    }
}
