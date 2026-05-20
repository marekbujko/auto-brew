import SwiftUI

/// The glyph rendered in the system menu bar. The mug stays put; a tiny
/// badge appears for the three states a glance-able user actually cares
/// about: running, just-finished, and failed.
struct MenuBarIcon: View {
    let state: SchedulerState
    @State private var pendingStore = PendingUpdatesStore.shared

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "mug.fill")
                .symbolRenderingMode(.hierarchical)
            if let badge = badgeIcon {
                Image(systemName: badge)
                    .font(.system(size: 7, weight: .bold))
            } else if pendingStore.pendingCount > 0 {
                // Subtle dot — the same hint the App Store uses when updates
                // need a tap. Numeric count is too big for the menu bar.
                Circle()
                    .fill(.orange)
                    .frame(width: 6, height: 6)
            }
        }
        .accessibilityLabel("AutoBrew")
        .accessibilityValue(accessibilityStatus)
    }

    private var badgeIcon: String? {
        switch state {
        case .running: "arrow.triangle.2.circlepath"
        case .completed: "checkmark"
        case .failed: "exclamationmark"
        default: nil
        }
    }

    private var accessibilityStatus: String {
        switch state {
        case .idle: "Idle"
        case .waitingForIdle: "Waiting for idle"
        case .waitingForSchedule: "Waiting for scheduled time"
        case .running: "Updating packages"
        case .completed: "Update completed"
        case .failed: "Update failed"
        }
    }
}
