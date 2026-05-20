import Foundation

/// Result of running every outdated package through the policy logic.
struct UpdateDecisionBundle: Sendable, Equatable {
    /// Will be passed to `brew upgrade` on the next run.
    var autoInstall: [OutdatedPackage] = []
    /// Inside the delay window — leave alone for now.
    var waitingForCooldown: [WaitingEntry] = []
    /// Major bumps (or rejected/pending) that need the user to look at them.
    var needsApproval: [PendingUpdate] = []
    /// `.skip` policy or already rejected — no action.
    var skipped: [SkippedEntry] = []
}

struct WaitingEntry: Sendable, Equatable {
    let package: OutdatedPackage
    let bumpType: VersionBumpType
    let firstSeen: Date
    let daysRemaining: Int
}

struct SkippedEntry: Sendable, Equatable {
    let package: OutdatedPackage
    let reason: SkipReason
}

enum SkipReason: String, Sendable, Equatable {
    case policySkip
    case rejected
}

/// Pure logic: takes outdated rows, policy settings, and the ledger, and
/// decides what should happen to each one. No I/O, no UI — easy to unit test.
struct UpdateEvaluator {
    let defaults: UpdatePolicyDefaults
    let overrides: [String: PackagePolicyOverride]
    /// Keyed by `(kind, token)` so cask/formula with the same name don't
    /// share a decision.
    var existingPending: [String: PendingUpdate]

    init(
        defaults: UpdatePolicyDefaults,
        overrides: [PackagePolicyOverride] = [],
        existingPending: [PendingUpdate] = []
    ) {
        self.defaults = defaults
        // `reduce(into:)` over `Dictionary(uniqueKeysWithValues:)` because
        // duplicate tokens in persisted data shouldn't crash — last write wins.
        self.overrides = overrides.reduce(into: [:]) { $0[$1.token] = $1 }
        self.existingPending = existingPending.reduce(into: [:]) { $0[Self.pendingKey(kind: $1.kind, token: $1.token)] = $1 }
    }

    /// Composite key for the existing-pending lookup. Kept package-private
    /// (via static func) so callers don't have to mirror the format.
    static func pendingKey(kind: PackageKind, token: String) -> String {
        "\(kind.rawValue)::\(token)"
    }

    func evaluate(_ outdated: [OutdatedPackage], ledger: UpdateLedger, now: Date) -> UpdateDecisionBundle {
        var bundle = UpdateDecisionBundle()
        var workingLedger = ledger

        for package in outdated {
            let kind: PackageKind = package.isCask ? .cask : .formula
            let bump = VersionBumpClassifier.classify(from: package.currentVersion, to: package.newVersion)

            // Per-package override first, then the global default.
            let override = overrides[package.name]
            let policy = override?.policy(for: bump) ?? defaults.policy(for: kind, bump: bump)

            switch policy {
            case .skip:
                bundle.skipped.append(SkippedEntry(package: package, reason: .policySkip))

            case .auto:
                bundle.autoInstall.append(package)

            case .delayedDays(let cooldown):
                let firstSeen = workingLedger.touch(kind: kind, token: package.name, version: package.newVersion, now: now)
                let elapsed = daysBetween(firstSeen, and: now)
                if elapsed >= cooldown {
                    bundle.autoInstall.append(package)
                } else {
                    bundle.waitingForCooldown.append(WaitingEntry(
                        package: package,
                        bumpType: bump,
                        firstSeen: firstSeen,
                        daysRemaining: max(0, cooldown - elapsed)
                    ))
                }

            case .manualApproval:
                let firstSeen = workingLedger.touch(kind: kind, token: package.name, version: package.newVersion, now: now)
                let prior = existingPending[Self.pendingKey(kind: kind, token: package.name)]

                if let prior, prior.availableVersion == package.newVersion {
                    // Same `(kind, token, version)`: carry the prior decision
                    // forward so the store keeps approve/reject sticky.
                    switch prior.decision {
                    case .approved:
                        bundle.autoInstall.append(package)
                    case .rejected, .pending:
                        // Both stay in needsApproval so the scheduler can
                        // re-hydrate the pending store and keep rejected
                        // entries sticky between runs.
                        bundle.needsApproval.append(prior)
                    }
                } else {
                    // No prior decision for this version (either nothing
                    // existed, or a newer version superseded it).
                    let pending = PendingUpdate(
                        id: prior?.id ?? UUID(),
                        token: package.name,
                        displayName: package.name,
                        kind: kind,
                        currentVersion: package.currentVersion,
                        availableVersion: package.newVersion,
                        bumpType: bump,
                        firstSeen: firstSeen,
                        decision: .pending
                    )
                    bundle.needsApproval.append(pending)
                }
            }
        }

        return bundle
    }

    /// Whole-day difference, floored. Same-day = 0, next-day = 1.
    private func daysBetween(_ earlier: Date, and later: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let start = calendar.startOfDay(for: earlier)
        let end = calendar.startOfDay(for: later)
        return calendar.dateComponents([.day], from: start, to: end).day ?? 0
    }
}
