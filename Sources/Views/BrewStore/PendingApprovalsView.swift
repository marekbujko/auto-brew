import SwiftUI

/// Lists every major update that's waiting for the user to say yes or no.
/// Approved entries roll into the next scheduled run; rejected ones stay
/// rejected until a newer version arrives.
struct PendingApprovalsView: View {
    @State private var store = PendingUpdatesStore.shared

    private var entries: [PendingUpdate] {
        store.updates.sorted { lhs, rhs in
            if lhs.decision.isPending != rhs.decision.isPending {
                return lhs.decision.isPending
            }
            return lhs.displayName.localizedCaseInsensitiveCompare(rhs.displayName) == .orderedAscending
        }
    }

    var body: some View {
        Group {
            if entries.isEmpty {
                ContentUnavailableView(
                    String(localized: "No Updates Need Approval"),
                    systemImage: "checkmark.seal",
                    description: Text(String(localized: "Major updates will appear here when AutoBrew detects them."))
                )
            } else {
                List(entries) { update in
                    PendingApprovalRow(update: update)
                }
                .listStyle(.inset)
                .toolbar {
                    ToolbarItemGroup {
                        Button(String(localized: "Approve All")) { approveAll() }
                            .disabled(!hasPending)
                        Button(String(localized: "Reject All"), role: .destructive) { rejectAll() }
                            .disabled(!hasPending)
                    }
                }
            }
        }
    }

    private var hasPending: Bool {
        store.updates.contains { $0.decision.isPending }
    }

    private func approveAll() {
        for entry in store.updates where entry.decision.isPending {
            store.approve(entry.id)
        }
    }

    private func rejectAll() {
        for entry in store.updates where entry.decision.isPending {
            store.reject(entry.id)
        }
    }
}

private struct PendingApprovalRow: View {
    let update: PendingUpdate
    @State private var store = PendingUpdatesStore.shared

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(update.displayName)
                    .font(.headline)
                HStack(spacing: 6) {
                    Text(update.currentVersion)
                        .foregroundStyle(.secondary)
                    Image(systemName: "arrow.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(update.availableVersion)
                        .foregroundStyle(.primary)
                }
                .font(.subheadline)
                HStack(spacing: 6) {
                    Text(update.kind == .cask
                         ? String(localized: "Cask")
                         : String(localized: "Formula"))
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .adaptiveGlassCapsule()
                    Text(bumpLabel)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .adaptiveGlassCapsule(tint: bumpColor)
                        .foregroundStyle(bumpColor)
                }
                statusLine
            }
            Spacer()
            actionButtons
        }
        .padding(.vertical, 6)
    }

    private var bumpLabel: String {
        switch update.bumpType {
        case .patch: return String(localized: "Patch")
        case .minor: return String(localized: "Minor")
        case .major, .unknown: return String(localized: "Major")
        }
    }

    private var bumpColor: Color {
        switch update.bumpType {
        case .patch: return .green
        case .minor: return .orange
        case .major, .unknown: return .red
        }
    }

    @ViewBuilder
    private var statusLine: some View {
        switch update.decision {
        case .pending:
            EmptyView()
        case .approved(let at):
            Label(String(localized: "Approved \(formatted(at))"), systemImage: "checkmark.circle.fill")
                .font(.caption)
                .foregroundStyle(.green)
        case .rejected(let at):
            Label(String(localized: "Rejected \(formatted(at))"), systemImage: "xmark.circle.fill")
                .font(.caption)
                .foregroundStyle(.red)
        }
    }

    @ViewBuilder
    private var actionButtons: some View {
        switch update.decision {
        case .pending:
            HStack(spacing: 6) {
                Button(String(localized: "Approve")) { store.approve(update.id) }
                    .adaptiveProminentButtonStyle()
                Button(String(localized: "Reject"), role: .destructive) { store.reject(update.id) }
                    .adaptiveBorderedButtonStyle()
            }
        case .approved, .rejected:
            Button(String(localized: "Undo")) { store.resetDecision(update.id) }
                .adaptiveBorderedButtonStyle()
        }
    }

    private func formatted(_ date: Date) -> String {
        date.formatted(.relative(presentation: .named))
    }
}
