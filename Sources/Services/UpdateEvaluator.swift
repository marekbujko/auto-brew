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
    var existingPending: [String: PendingUpdate]  // keyed by token

    init(
        defaults: UpdatePolicyDefaults,
        overrides: [PackagePolicyOverride] = [],
        existingPending: [PendingUpdate] = []
    ) {
        self.defaults = defaults
        self.overrides = Dictionary(uniqueKeysWithValues: overrides.map { ($0.token, $0) })
        self.existingPending = Dictionary(uniqueKeysWithValues: existingPending.map { ($0.token, $0) })
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

            // Decide based on policy.
            switch policy {
            case .skip:
                bundle.skipped.append(SkippedEntry(package: package, reason: .policySkip))

            case .auto:
                bundle.autoInstall.append(package)

            case .delayedDays(let cooldown):
                let firstSeen = workingLedger.touch(token: package.name, version: package.newVersion, now: now)
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
                let firstSeen = workingLedger.touch(token: package.name, version: package.newVersion, now: now)
                let prior = existingPending[package.name]

                if let prior, prior.availableVersion == package.newVersion {
                    switch prior.decision {
                    case .approved:
                        bundle.autoInstall.append(package)
                    case .rejected:
                        bundle.skipped.append(SkippedEntry(package: package, reason: .rejected))
                    case .pending:
                        bundle.needsApproval.append(prior)
                    }
                } else {
                    // Either no prior decision, or this is a newer version.
                    // In both cases the user gets a fresh pending entry.
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
