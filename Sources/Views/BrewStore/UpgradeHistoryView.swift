import SwiftUI

/// Audit log of every auto-upgrade plus one-click rollback when the
/// pre-upgrade snapshot still exists. The rollback runs straight through
/// `SnapshotService.restoreSnapshot(_:terminateApp:)` — the full
/// `RestoreWizard` would needlessly try to reinstall the cask that the
/// upgrade just installed.
struct UpgradeHistoryView: View {
    @State private var historyStore = UpgradeHistoryStore.shared
    @State private var availableSnapshots: [UUID: AppSnapshot] = [:]
    @State private var pendingConfirmation: UpgradeHistoryEntry?
    @State private var restoreInProgress: UUID?
    @State private var restoreResult: RestoreResult?

    private struct RestoreResult: Identifiable {
        let id = UUID()
        let title: String
        let message: String
        let isError: Bool
    }

    var body: some View {
        Group {
            if historyStore.entries.isEmpty {
                emptyState
            } else {
                list
            }
        }
        .task { reloadAvailableSnapshots() }
        .onChange(of: historyStore.entries.count) { _, _ in reloadAvailableSnapshots() }
        .confirmationDialog(
            String(localized: "Roll back to the snapshot taken before this upgrade?"),
            isPresented: confirmationBinding,
            presenting: pendingConfirmation
        ) { entry in
            Button(String(localized: "Roll Back"), role: .destructive) {
                Task { await performRollback(for: entry) }
            }
            Button(String(localized: "Cancel"), role: .cancel) {
                pendingConfirmation = nil
            }
        } message: { entry in
            Text(String(localized: "AutoBrew will quit \(entry.displayName) and restore its user data from the snapshot taken right before the \(entry.fromVersion) → \(entry.toVersion) upgrade. The upgraded \(entry.displayName) binary itself stays in place — only your settings and data are reverted."))
        }
        .alert(item: $restoreResult) { result in
            Alert(
                title: Text(result.title),
                message: Text(result.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // MARK: - States

    private var emptyState: some View {
        ContentUnavailableView(
            String(localized: "No auto-upgrades yet"),
            systemImage: "clock.arrow.circlepath",
            description: Text(String(localized: "Once AutoBrew installs an update on its own, the run shows up here. If pre-upgrade snapshots are enabled in Settings, you can roll back from this view with one click."))
        )
    }

    private var list: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(historyStore.entries) { entry in
                    row(for: entry)
                }
            }
            .padding(16)
        }
    }

    @ViewBuilder
    private func row(for entry: UpgradeHistoryEntry) -> some View {
        HStack(alignment: .center, spacing: 12) {
            statusIcon(for: entry)

            VStack(alignment: .leading, spacing: 2) {
                Text(entry.displayName)
                    .font(.body.weight(.medium))
                HStack(spacing: 6) {
                    Text(entry.fromVersion)
                        .foregroundStyle(.secondary)
                    Image(systemName: "arrow.right")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(entry.toVersion)
                    Text("·")
                        .foregroundStyle(.tertiary)
                    Text(entry.timestamp, format: .relative(presentation: .named))
                        .foregroundStyle(.secondary)
                }
                .font(.callout)
            }

            Spacer()

            rollbackControl(for: entry)
        }
        .padding(12)
        .adaptiveGlassCard(cornerRadius: 10)
    }

    @ViewBuilder
    private func statusIcon(for entry: UpgradeHistoryEntry) -> some View {
        if entry.succeeded {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .imageScale(.large)
        } else {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
                .imageScale(.large)
        }
    }

    @ViewBuilder
    private func rollbackControl(for entry: UpgradeHistoryEntry) -> some View {
        if restoreInProgress == entry.id {
            ProgressView()
                .controlSize(.small)
        } else if let snapshotID = entry.snapshotID, availableSnapshots[snapshotID] != nil {
            Button {
                pendingConfirmation = entry
            } label: {
                Label(String(localized: "Roll Back"), systemImage: "arrow.uturn.backward")
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
        } else if entry.snapshotID != nil {
            // We had a snapshot at upgrade time but it's gone now — usually
            // pruned by the retention policy. Surface that explicitly so the
            // user doesn't expect a rollback that no longer exists.
            Label(String(localized: "Snapshot pruned"), systemImage: "trash")
                .labelStyle(.titleAndIcon)
                .font(.caption)
                .foregroundStyle(.secondary)
        } else {
            Label(String(localized: "No snapshot"), systemImage: "minus.circle")
                .labelStyle(.titleAndIcon)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }

    // MARK: - Actions

    private var confirmationBinding: Binding<Bool> {
        Binding(
            get: { pendingConfirmation != nil },
            set: { if !$0 { pendingConfirmation = nil } }
        )
    }

    private func reloadAvailableSnapshots() {
        let snapshots = (try? SnapshotService.shared.listSnapshots()) ?? []
        var map: [UUID: AppSnapshot] = [:]
        for snap in snapshots { map[snap.id] = snap }
        availableSnapshots = map
        // History rows keep their `snapshotID` even after a snapshot is pruned
        // so the audit link survives — the rollback button is gated on the
        // live `availableSnapshots` map, which falls through to the "Snapshot
        // pruned" branch when the disk no longer has it.
    }

    private func performRollback(for entry: UpgradeHistoryEntry) async {
        pendingConfirmation = nil
        guard let snapshotID = entry.snapshotID,
              let snapshot = availableSnapshots[snapshotID] else {
            restoreResult = RestoreResult(
                title: String(localized: "Snapshot unavailable"),
                message: String(localized: "The snapshot for this upgrade is no longer on disk — it was probably removed by retention or manual cleanup."),
                isError: true
            )
            return
        }
        restoreInProgress = entry.id
        defer { restoreInProgress = nil }
        do {
            try await SnapshotService.shared.restoreSnapshot(snapshot, terminateApp: true)
            restoreResult = RestoreResult(
                title: String(localized: "Rolled back"),
                message: String(localized: "\(entry.displayName) is back on the user data from before the \(entry.fromVersion) → \(entry.toVersion) upgrade."),
                isError: false
            )
        } catch {
            restoreResult = RestoreResult(
                title: String(localized: "Rollback failed"),
                message: error.localizedDescription,
                isError: true
            )
        }
    }
}
