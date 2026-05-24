import SwiftUI

/// Per-package override editor. Three optional pickers (one per bump type)
/// that each fall back to the global default when set to "Default".
/// Saving is immediate — the sheet only acts as a confirmation surface.
struct PackagePolicyOverrideSheet: View {
    let token: String
    let displayName: String

    @Environment(\.dismiss) private var dismiss
    @State private var settings = SettingsStore.shared

    @State private var patch: UpdatePolicy?
    @State private var minor: UpdatePolicy?
    @State private var major: UpdatePolicy?
    @State private var preSnapshotCommand: String = ""
    @State private var showHookConfirmation = false

    init(token: String, displayName: String) {
        self.token = token
        self.displayName = displayName
        let existing = SettingsStore.shared.packageOverrides.first { $0.token == token }
        _patch = State(initialValue: existing?.patch)
        _minor = State(initialValue: existing?.minor)
        _major = State(initialValue: existing?.major)
        _preSnapshotCommand = State(initialValue: existing?.preSnapshotCommand ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(String(localized: "Override the default update policy for this package. Leave a row on \"Default\" to inherit the global setting."))
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }

                Section {
                    optionalPicker(String(localized: "Patch updates"), selection: $patch)
                    optionalPicker(String(localized: "Minor updates"), selection: $minor)
                    optionalPicker(String(localized: "Major updates"), selection: $major)
                } header: {
                    Text(displayName).font(.headline)
                }

                Section {
                    TextField(String(localized: "e.g. osascript -e 'tell application \"Logic Pro\" to save'"),
                              text: $preSnapshotCommand,
                              axis: .vertical)
                        .lineLimit(2...4)
                        .font(.callout.monospaced())
                    Label(String(localized: "Runs with your user permissions via /bin/bash -c, 30 s timeout. Don't paste commands you can't read end-to-end — they execute as you, on your data."),
                          systemImage: "exclamationmark.shield")
                        .font(.caption)
                        .foregroundStyle(.orange)
                } header: {
                    Text(String(localized: "Pre-snapshot command"))
                } footer: {
                    Text(String(localized: "Fires once per auto-upgrade right before the pre-upgrade snapshot. Use it to flush in-memory state (save unsaved docs, quit a daemon, …) so the snapshot captures a quiescent on-disk state."))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                if hasOverride {
                    Section {
                        Button(role: .destructive) {
                            patch = nil
                            minor = nil
                            major = nil
                            preSnapshotCommand = ""
                        } label: {
                            Label(String(localized: "Reset to defaults"), systemImage: "arrow.uturn.backward")
                        }
                    }
                }
            }
            .formStyle(.grouped)
            .frame(minWidth: 420, minHeight: 360)
            .navigationTitle(String(localized: "Update Policy"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "Cancel")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(String(localized: "Save")) {
                        save()
                        dismiss()
                    }
                }
            }
        }
    }

    private var hasOverride: Bool {
        patch != nil || minor != nil || major != nil ||
        !preSnapshotCommand.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func optionalPicker(_ label: String, selection: Binding<UpdatePolicy?>) -> some View {
        Picker(label, selection: selection) {
            Text(String(localized: "Default")).tag(UpdatePolicy?.none)
            ForEach(UpdatePolicy.presetOptions, id: \.caseID) { policy in
                Text(LocalizedStringKey(policy.titleKey)).tag(UpdatePolicy?.some(policy))
            }
        }
    }

    private func save() {
        var overrides = settings.packageOverrides
        overrides.removeAll { $0.token == token }
        let trimmedCommand = preSnapshotCommand.trimmingCharacters(in: .whitespaces)
        let override = PackagePolicyOverride(
            token: token,
            patch: patch,
            minor: minor,
            major: major,
            preSnapshotCommand: trimmedCommand.isEmpty ? nil : trimmedCommand
        )
        if !override.isEmpty {
            overrides.append(override)
        }
        settings.packageOverrides = overrides
    }
}
