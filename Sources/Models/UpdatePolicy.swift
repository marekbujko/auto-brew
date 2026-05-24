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
        case (.cask, .major), (.cask, .unknown): return caskMajor
        case (.formula, .patch): return formulaPatch
        case (.formula, .minor): return formulaMinor
        case (.formula, .major), (.formula, .unknown): return formulaMajor
        }
    }
}

/// Per-package opt-out from the defaults. Any field left `nil` falls back to
/// the matching value in `UpdatePolicyDefaults`.
///
/// `preSnapshotCommand` is the optional shell command AutoBrew runs
/// (via `/bin/bash -c`, 30 s timeout) right before
/// `SnapshotService.createSnapshot` for this cask's auto-upgrade. Use
/// it to flush in-memory state from the live app — e.g.,
/// `osascript -e 'tell application "Logic Pro" to save'` — so the
/// snapshot captures a quiescent on-disk state. Empty/nil → no hook.
struct PackagePolicyOverride: Codable, Sendable, Equatable, Identifiable {
    var token: String
    var patch: UpdatePolicy?
    var minor: UpdatePolicy?
    var major: UpdatePolicy?
    var preSnapshotCommand: String?

    var id: String { token }

    var isEmpty: Bool {
        patch == nil && minor == nil && major == nil &&
        (preSnapshotCommand?.isEmpty ?? true)
    }

    func policy(for bump: VersionBumpType) -> UpdatePolicy? {
        switch bump {
        case .patch: return patch
        case .minor: return minor
        case .major, .unknown: return major
        }
    }

    // Backward-compat decode: existing override files do not carry the
    // new field; decodeIfPresent handles their absence cleanly.
    enum CodingKeys: String, CodingKey {
        case token, patch, minor, major, preSnapshotCommand
    }

    init(token: String,
         patch: UpdatePolicy? = nil,
         minor: UpdatePolicy? = nil,
         major: UpdatePolicy? = nil,
         preSnapshotCommand: String? = nil) {
        self.token = token
        self.patch = patch
        self.minor = minor
        self.major = major
        self.preSnapshotCommand = preSnapshotCommand
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        token = try c.decode(String.self, forKey: .token)
        patch = try c.decodeIfPresent(UpdatePolicy.self, forKey: .patch)
        minor = try c.decodeIfPresent(UpdatePolicy.self, forKey: .minor)
        major = try c.decodeIfPresent(UpdatePolicy.self, forKey: .major)
        preSnapshotCommand = try c.decodeIfPresent(String.self, forKey: .preSnapshotCommand)
    }
}
