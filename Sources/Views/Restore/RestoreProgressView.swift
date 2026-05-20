import SwiftUI

/// Per-app status line during a running restore. Restores are sequential and
/// can each take minutes (brew install + ditto copy), so the user gets a
/// readable label per bundle rather than a single indeterminate spinner.
struct RestoreProgressView: View {
    @Bindable var store: RestoreWizardStore

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(store.snapshots) { snap in
                HStack {
                    Text(snap.displayName).font(.callout).bold()
                    Spacer()
                    Text(store.progress[snap.bundleID] ?? "—").font(.caption).foregroundStyle(.secondary)
                }
            }
        }.padding()
    }
}
