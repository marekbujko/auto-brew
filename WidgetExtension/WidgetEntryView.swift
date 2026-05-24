import SwiftUI
import WidgetKit

/// Three-family SwiftUI surface for the AutoBrew status widget. The
/// view trees per family are intentionally separate (rather than one
/// scaling layout) so each size can prioritise different signals —
/// small shows just the headline, large shows the actionable rollback
/// button.
struct AutoBrewWidgetEntryView: View {
    var entry: AutoBrewStateProvider.Entry

    @Environment(\.widgetFamily) private var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallBody
        case .systemMedium:
            mediumBody
        case .systemLarge:
            largeBody
        default:
            mediumBody
        }
    }

    // MARK: - Small

    private var smallBody: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: entry.state.pendingApprovals > 0 ? "exclamationmark.circle.fill" : "checkmark.seal.fill")
                .foregroundStyle(entry.state.pendingApprovals > 0 ? .orange : .green)
                .imageScale(.large)
            Text(headlineCount)
                .font(.title2.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(headlineLabel)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            Spacer(minLength: 0)
            updatedFooter
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: - Medium

    private var mediumBody: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Image(systemName: entry.state.pendingApprovals > 0 ? "exclamationmark.circle.fill" : "checkmark.seal.fill")
                    .foregroundStyle(entry.state.pendingApprovals > 0 ? .orange : .green)
                Text(headlineCount)
                    .font(.title3.bold())
                Text(headlineLabel)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                Spacer(minLength: 0)
                updatedFooter
            }
            .frame(maxWidth: 110, alignment: .leading)

            Divider()

            VStack(alignment: .leading, spacing: 4) {
                if entry.state.recentUpgrades.isEmpty {
                    Text(String(localized: "No recent upgrades"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(entry.state.recentUpgrades.prefix(3)) { row in
                        upgradeRow(row)
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: - Large

    private var largeBody: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: entry.state.pendingApprovals > 0 ? "exclamationmark.circle.fill" : "checkmark.seal.fill")
                    .foregroundStyle(entry.state.pendingApprovals > 0 ? .orange : .green)
                Text(headlineCount)
                    .font(.title3.bold())
                Text(headlineLabel)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Spacer()
            }

            Divider()

            if entry.state.recentUpgrades.isEmpty {
                Text(String(localized: "No upgrades recorded yet"))
                    .font(.callout)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(entry.state.recentUpgrades.prefix(5)) { row in
                    upgradeRow(row)
                }
            }

            Spacer(minLength: 4)

            if entry.state.rollbackCandidateID != nil {
                rollBackButton
            }

            updatedFooter
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    // MARK: - Reusables

    @ViewBuilder
    private func upgradeRow(_ row: WidgetState.UpgradeRow) -> some View {
        HStack(spacing: 6) {
            outcomeIcon(row.outcome)
            VStack(alignment: .leading, spacing: 0) {
                Text(row.displayName)
                    .font(.caption.weight(.medium))
                    .lineLimit(1)
                Text("\(row.fromVersion) → \(row.toVersion)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer(minLength: 0)
            Text(row.timestamp, format: .relative(presentation: .numeric))
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .lineLimit(1)
        }
    }

    @ViewBuilder
    private func outcomeIcon(_ outcome: CaskUpgradeOutcome) -> some View {
        switch outcome {
        case .succeeded:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
        case .failed:
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.red)
        case .attempted:
            Image(systemName: "questionmark.circle.fill")
                .foregroundStyle(.orange)
        }
    }

    @ViewBuilder
    private var rollBackButton: some View {
        // The widget extension is sandboxed and cannot itself reach
        // SnapshotService — so the Roll Back tap goes back to the host
        // app via the `autobrew://rollback` URL scheme. AppDelegate
        // matches the action to the same rollback path the failed-
        // upgrade notification uses.
        Link(destination: URL(string: "autobrew://rollback")!) {
            Label(String(localized: "Roll Back Last Failed"), systemImage: "arrow.uturn.backward")
                .font(.caption)
        }
    }

    private var updatedFooter: some View {
        Group {
            if entry.state.updatedAt > .distantPast {
                Text(String(localized: "Updated \(entry.state.updatedAt.formatted(.relative(presentation: .named)))"))
            } else {
                Text(String(localized: "Open AutoBrew to populate this widget"))
            }
        }
        .font(.caption2)
        .foregroundStyle(.tertiary)
        .lineLimit(1)
    }

    private var headlineCount: String {
        entry.state.pendingApprovals == 0
            ? String(localized: "Up to date")
            : "\(entry.state.pendingApprovals)"
    }

    private var headlineLabel: String {
        if entry.state.pendingApprovals == 0 {
            return String(localized: "No pending approvals")
        }
        let preview = entry.state.pendingSampleNames.prefix(3).joined(separator: ", ")
        return preview.isEmpty
            ? String(localized: "pending approvals")
            : String(localized: "pending: \(preview)")
    }
}
