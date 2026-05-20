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

    init(token: String, displayName: String) {
        self.token = token
        self.displayName = displayName
        let existing = SettingsStore.shared.packageOverrides.first { $0.token == token }
        _patch = State(initialValue: existing?.patch)
        _minor = State(initialValue: existing?.minor)
        _major = State(initialValue: existing?.major)
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

                if hasOverride {
                    Section {
                        Button(role: .destructive) {
                            patch = nil
                            minor = nil
                            major = nil
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
        patch != nil || minor != nil || major != nil
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
        let override = PackagePolicyOverride(token: token, patch: patch, minor: minor, major: major)
        if !override.isEmpty {
            overrides.append(override)
        }
        settings.packageOverrides = overrides
    }
}
