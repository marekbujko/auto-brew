import SwiftUI

/// Picker sheet that lets the user select which other snapshot of the
/// same bundle to diff against. Surfaced from `SnapshotDetailView`'s
/// Compare button — only shows snapshots whose `bundleID` matches the
/// one currently being viewed, so the diff is always meaningful.
struct SnapshotComparePicker: View {
    let left: AppSnapshot
    let candidates: [AppSnapshot]
    let onSelect: (AppSnapshot) -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "Compare \(left.displayName) snapshot from \(left.createdAt.formatted(date: .abbreviated, time: .shortened)) with…"))
                .font(.headline)
            List(candidates) { candidate in
                Button {
                    onSelect(candidate)
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(candidate.createdAt.formatted(date: .complete, time: .standard))
                            .font(.callout)
                        HStack(spacing: 6) {
                            Text(ByteFormatter.string(candidate.totalBytes))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            if let version = candidate.sourceAppVersion {
                                Text("·").foregroundStyle(.tertiary)
                                Text(version)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .frame(minWidth: 420, minHeight: 240)
            HStack {
                Button(String(localized: "Cancel"), role: .cancel, action: onCancel)
                Spacer()
            }
        }
        .padding(20)
    }
}

/// Renders the result of `SnapshotService.diff` as four labelled
/// sections (added / removed / changed / unchanged). The diff itself
/// is computed once when the sheet appears; if loading either
/// manifest fails the error surfaces inline so the user knows why
/// nothing rendered.
struct SnapshotCompareView: View {
    let left: AppSnapshot
    let right: AppSnapshot

    @Environment(\.dismiss) private var dismiss
    @State private var diff: SnapshotDiff?
    @State private var loadError: String?

    private var older: AppSnapshot { left.createdAt <= right.createdAt ? left : right }
    private var newer: AppSnapshot { left.createdAt <= right.createdAt ? right : left }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            Divider()
            if let loadError {
                ContentUnavailableView(
                    String(localized: "Could not load diff"),
                    systemImage: "exclamationmark.triangle",
                    description: Text(loadError)
                )
            } else if let diff {
                summary(for: diff)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        if !diff.added.isEmpty {
                            section(title: String(localized: "Added in newer"),
                                    color: .green,
                                    rows: diff.added.map(makeRow(from:)))
                        }
                        if !diff.removed.isEmpty {
                            section(title: String(localized: "Removed in newer"),
                                    color: .red,
                                    rows: diff.removed.map(makeRow(from:)))
                        }
                        if !diff.changed.isEmpty {
                            section(title: String(localized: "Changed"),
                                    color: .orange,
                                    rows: diff.changed.map(makeRow(from:)))
                        }
                        if diff.added.isEmpty && diff.removed.isEmpty && diff.changed.isEmpty {
                            Text(String(localized: "Both snapshots have identical components."))
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                        }
                    }
                    .padding(.vertical, 8)
                }
            } else {
                ProgressView().frame(maxWidth: .infinity)
            }
            HStack {
                Spacer()
                Button(String(localized: "Close")) { dismiss() }
                    .keyboardShortcut(.defaultAction)
            }
        }
        .padding(20)
        .frame(minWidth: 560, minHeight: 460)
        .task { loadDiff() }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(left.displayName)
                .font(.title3.bold())
            HStack(spacing: 4) {
                Text(older.createdAt.formatted(date: .abbreviated, time: .shortened))
                Image(systemName: "arrow.right").foregroundStyle(.tertiary)
                Text(newer.createdAt.formatted(date: .abbreviated, time: .shortened))
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func summary(for diff: SnapshotDiff) -> some View {
        HStack(spacing: 16) {
            summaryStat(label: String(localized: "Added"),
                        count: diff.added.count,
                        size: diff.totalAddedBytes,
                        color: .green)
            summaryStat(label: String(localized: "Removed"),
                        count: diff.removed.count,
                        size: diff.totalRemovedBytes,
                        color: .red)
            summaryStat(label: String(localized: "Changed"),
                        count: diff.changed.count,
                        size: diff.totalChangedBytesDelta,
                        color: .orange,
                        signed: true)
            summaryStat(label: String(localized: "Unchanged"),
                        count: diff.unchanged.count,
                        size: nil,
                        color: .secondary)
        }
    }

    @ViewBuilder
    private func summaryStat(label: String, count: Int, size: Int64?, color: Color, signed: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(spacing: 4) {
                Text("\(count)")
                    .font(.title3.bold().monospacedDigit())
                    .foregroundStyle(color)
                if let size {
                    Text(signed ? formattedSignedSize(size) : ByteFormatter.string(size))
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func formattedSignedSize(_ bytes: Int64) -> String {
        let sign = bytes >= 0 ? "+" : "−"
        return "\(sign)\(ByteFormatter.string(abs(bytes)))"
    }

    private struct DiffRow: Identifiable {
        let id = UUID()
        let primary: String
        let secondary: String
    }

    @ViewBuilder
    private func section(title: String, color: Color, rows: [DiffRow]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.callout.weight(.medium))
                .foregroundStyle(color)
            ForEach(rows) { row in
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "doc")
                        .foregroundStyle(.secondary)
                        .imageScale(.small)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(row.primary)
                            .font(.callout.monospaced())
                            .lineLimit(1)
                            .truncationMode(.middle)
                        Text(row.secondary)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 1)
            }
        }
    }

    private func makeRow(from component: SnapshotComponent) -> DiffRow {
        DiffRow(
            primary: component.originalPath,
            secondary: ByteFormatter.string(component.byteSize)
        )
    }

    private func makeRow(from pair: SnapshotDiff.Pair) -> DiffRow {
        DiffRow(
            primary: pair.newComponent.originalPath,
            secondary: "\(ByteFormatter.string(pair.oldComponent.byteSize)) → \(ByteFormatter.string(pair.newComponent.byteSize))  (\(formattedSignedSize(pair.byteDelta)))"
        )
    }

    private func loadDiff() {
        do {
            diff = try SnapshotService.shared.diff(older, newer)
        } catch {
            loadError = error.localizedDescription
        }
    }
}
