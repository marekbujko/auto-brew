import SwiftUI

/// Settings section that controls the default update policy. Six pickers —
/// patch/minor/major across casks and formulae. The actual `UpdatePolicy`
/// cases are normalised into picker tags so SwiftUI can compare them.
struct UpdatePolicySection: View {
    @Binding var defaults: UpdatePolicyDefaults

    var body: some View {
        Section(String(localized: "Update Policy — Casks")) {
            policyPicker(String(localized: "Patch updates"), binding: $defaults.caskPatch)
            policyPicker(String(localized: "Minor updates"), binding: $defaults.caskMinor)
            policyPicker(String(localized: "Major updates"), binding: $defaults.caskMajor)
        }

        Section(String(localized: "Update Policy — Formulae")) {
            policyPicker(String(localized: "Patch updates"), binding: $defaults.formulaPatch)
            policyPicker(String(localized: "Minor updates"), binding: $defaults.formulaMinor)
            policyPicker(String(localized: "Major updates"), binding: $defaults.formulaMajor)
        }
    }

    private func policyPicker(_ label: String, binding: Binding<UpdatePolicy>) -> some View {
        Picker(label, selection: binding) {
            ForEach(UpdatePolicy.presetOptions, id: \.caseID) { policy in
                Text(LocalizedStringKey(policy.titleKey)).tag(policy)
            }
        }
    }
}
