import Foundation

/// What AutoBrew should do when a new version of a package shows up.
enum UpdatePolicy: Codable, Sendable, Equatable, Hashable {
    /// Install on the next scheduled run.
    case auto
    /// Wait this many days after the version first showed up before installing.
    case delayedDays(Int)
    /// Don't install until the user explicitly approves it.
    case manualApproval
    /// Never install — the package stays pinned at its current version.
    case skip
}

extension UpdatePolicy {
    /// Stable identifier used in pickers and persisted overrides.
    var caseID: String {
        switch self {
        case .auto: return "auto"
        case .delayedDays(let days): return "delayed-\(days)"
        case .manualApproval: return "approval"
        case .skip: return "skip"
        }
    }

    /// User-facing label key — resolved through Localizable.xcstrings.
    var titleKey: String {
        switch self {
        case .auto: return "Auto"
        case .delayedDays(let days): return "Wait \(days) days"
        case .manualApproval: return "Ask me"
        case .skip: return "Skip"
        }
    }

    /// Common picker options shown in the Settings UI. The custom-days variant
    /// lives outside this list — the UI swaps in the user-chosen value.
    static let presetOptions: [UpdatePolicy] = [
        .auto,
        .delayedDays(2),
        .delayedDays(7),
        .delayedDays(14),
        .delayedDays(30),
        .manualApproval,
        .skip
    ]
}

/// Whether a row from `brew outdated` is a cask or a formula. Drives both the
/// upgrade command (`brew upgrade` vs `brew upgrade --cask`) and the default
/// policy chosen for it — formulae default to faster patch updates because
/// they tend to carry security fixes.
enum PackageKind: String, Codable, Sendable, Equatable {
    case cask
    case formula
}

/// Defaults applied when no per-package override exists.
struct UpdatePolicyDefaults: Codable, Sendable, Equatable {
    var caskPatch: UpdatePolicy
    var caskMinor: UpdatePolicy
    var caskMajor: UpdatePolicy
    var formulaPatch: UpdatePolicy
    var formulaMinor: UpdatePolicy
    var formulaMajor: UpdatePolicy

    /// Conservative starter values: patches roll out quickly, minors get a
    /// cool-off window, anything that smells like a major bump needs the user
    /// to look at it. Formulae trend more aggressive because security
    /// updates ride along with patch bumps.
    static let safeDefaults = UpdatePolicyDefaults(
        caskPatch: .delayedDays(2),
        caskMinor: .delayedDays(14),
        caskMajor: .manualApproval,
        formulaPatch: .auto,
        formulaMinor: .delayedDays(7),
        formulaMajor: .manualApproval
    )

    func policy(for kind: PackageKind, bump: VersionBumpType) -> UpdatePolicy {
        // `.unknown` bump types are treated as major so we don't slip something
        // unexpected past the user.
        let effectiveBump: VersionBumpType = (bump == .unknown) ? .major : bump
        switch (kind, effectiveBump) {
        case (.cask, .patch): return caskPatch
        case (.cask, .minor): return caskMinor
        case (.cask, .major): return caskMajor
        case (.formula, .patch): return formulaPatch
        case (.formula, .minor): return formulaMinor
        case (.formula, .major): return formulaMajor
        case (_, .unknown): return .manualApproval  // unreachable, see effectiveBump
        }
    }
}

/// Per-package opt-out from the defaults. Any field left `nil` falls back to
/// the matching value in `UpdatePolicyDefaults`.
struct PackagePolicyOverride: Codable, Sendable, Equatable, Identifiable {
    var token: String
    var patch: UpdatePolicy?
    var minor: UpdatePolicy?
    var major: UpdatePolicy?

    var id: String { token }

    var isEmpty: Bool { patch == nil && minor == nil && major == nil }

    func policy(for bump: VersionBumpType) -> UpdatePolicy? {
        let effectiveBump: VersionBumpType = (bump == .unknown) ? .major : bump
        switch effectiveBump {
        case .patch: return patch
        case .minor: return minor
        case .major: return major
        case .unknown: return major  // unreachable
        }
    }
}
