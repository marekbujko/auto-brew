import XCTest
@testable import AutoBrew

final class UpdateEvaluatorTests: XCTestCase {
    private let referenceDate = Date(timeIntervalSince1970: 1_700_000_000)

    // MARK: - Helpers

    private func cask(_ name: String, _ current: String, _ available: String) -> OutdatedPackage {
        OutdatedPackage(name: name, currentVersion: current, newVersion: available, isCask: true)
    }

    private func formula(_ name: String, _ current: String, _ available: String) -> OutdatedPackage {
        OutdatedPackage(name: name, currentVersion: current, newVersion: available, isCask: false)
    }

    // MARK: - Auto

    func testAutoPolicyRoutesToAutoInstall() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .auto
        let evaluator = UpdateEvaluator(defaults: defaults)
        let result = evaluator.evaluate([cask("firefox", "120.0.0", "120.0.1")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.autoInstall.map(\.name), ["firefox"])
        XCTAssertTrue(result.waitingForCooldown.isEmpty)
    }

    // MARK: - DelayedDays

    func testDelayInsideWindowGoesToCooldown() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .delayedDays(7)
        let evaluator = UpdateEvaluator(defaults: defaults)
        let result = evaluator.evaluate([cask("firefox", "120.0.0", "120.0.1")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertTrue(result.autoInstall.isEmpty)
        XCTAssertEqual(result.waitingForCooldown.count, 1)
        XCTAssertEqual(result.waitingForCooldown.first?.daysRemaining, 7)
    }

    func testDelayPastWindowGoesToAutoInstall() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .delayedDays(3)

        var ledger = UpdateLedger()
        let seenEightDaysAgo = referenceDate.addingTimeInterval(-8 * 86_400)
        _ = ledger.touch(token: "firefox", version: "120.0.1", now: seenEightDaysAgo)

        let evaluator = UpdateEvaluator(defaults: defaults)
        let result = evaluator.evaluate([cask("firefox", "120.0.0", "120.0.1")], ledger: ledger, now: referenceDate)
        XCTAssertEqual(result.autoInstall.map(\.name), ["firefox"])
    }

    // MARK: - Manual approval

    func testManualApprovalCreatesPending() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskMajor = .manualApproval
        let evaluator = UpdateEvaluator(defaults: defaults)
        let result = evaluator.evaluate([cask("vscode", "1.83.0", "2.0.0")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertTrue(result.autoInstall.isEmpty)
        XCTAssertEqual(result.needsApproval.count, 1)
        XCTAssertTrue(result.needsApproval.first?.decision.isPending ?? false)
    }

    func testApprovedManualEntryGoesToAutoInstall() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskMajor = .manualApproval

        let priorApproval = PendingUpdate(
            token: "vscode",
            displayName: "vscode",
            kind: .cask,
            currentVersion: "1.83.0",
            availableVersion: "2.0.0",
            bumpType: .major,
            firstSeen: referenceDate.addingTimeInterval(-86_400),
            decision: .approved(at: referenceDate)
        )

        let evaluator = UpdateEvaluator(defaults: defaults, existingPending: [priorApproval])
        let result = evaluator.evaluate([cask("vscode", "1.83.0", "2.0.0")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.autoInstall.map(\.name), ["vscode"])
        XCTAssertTrue(result.needsApproval.isEmpty)
    }

    func testRejectedManualEntryGoesToSkipped() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskMajor = .manualApproval

        let priorRejection = PendingUpdate(
            token: "vscode",
            displayName: "vscode",
            kind: .cask,
            currentVersion: "1.83.0",
            availableVersion: "2.0.0",
            bumpType: .major,
            firstSeen: referenceDate,
            decision: .rejected(at: referenceDate)
        )

        let evaluator = UpdateEvaluator(defaults: defaults, existingPending: [priorRejection])
        let result = evaluator.evaluate([cask("vscode", "1.83.0", "2.0.0")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.skipped.count, 1)
        XCTAssertEqual(result.skipped.first?.reason, .rejected)
    }

    func testNewerVersionResetsPriorRejection() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskMajor = .manualApproval

        let oldRejection = PendingUpdate(
            token: "vscode",
            displayName: "vscode",
            kind: .cask,
            currentVersion: "1.83.0",
            availableVersion: "2.0.0",
            bumpType: .major,
            firstSeen: referenceDate,
            decision: .rejected(at: referenceDate)
        )

        let evaluator = UpdateEvaluator(defaults: defaults, existingPending: [oldRejection])
        // newer version arrives → should re-ask the user
        let result = evaluator.evaluate([cask("vscode", "1.83.0", "3.0.0")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.needsApproval.count, 1)
        XCTAssertTrue(result.needsApproval.first?.decision.isPending ?? false)
    }

    // MARK: - Skip

    func testSkipPolicyGoesToSkipped() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .skip
        let evaluator = UpdateEvaluator(defaults: defaults)
        let result = evaluator.evaluate([cask("firefox", "120.0.0", "120.0.1")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.skipped.count, 1)
        XCTAssertEqual(result.skipped.first?.reason, .policySkip)
    }

    // MARK: - Per-package overrides

    func testPackageOverrideBeatsDefaults() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .auto

        let override = PackagePolicyOverride(token: "firefox", patch: .skip, minor: nil, major: nil)
        let evaluator = UpdateEvaluator(defaults: defaults, overrides: [override])
        let result = evaluator.evaluate([cask("firefox", "120.0.0", "120.0.1")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.skipped.count, 1)
    }

    func testPartialOverrideFallsBackForOtherBumpTypes() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .auto
        defaults.caskMajor = .manualApproval

        let override = PackagePolicyOverride(token: "firefox", patch: nil, minor: nil, major: .auto)
        let evaluator = UpdateEvaluator(defaults: defaults, overrides: [override])

        // patch falls back to default (.auto)
        let patchResult = evaluator.evaluate([cask("firefox", "120.0.0", "120.0.1")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(patchResult.autoInstall.count, 1)

        // major hits the override (.auto, not default .manualApproval)
        let majorResult = evaluator.evaluate([cask("firefox", "120.0.0", "121.0.0")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(majorResult.autoInstall.count, 1)
    }

    // MARK: - Unknown bump type

    func testUnknownBumpRoutesThroughMajorPolicy() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskMajor = .manualApproval
        let evaluator = UpdateEvaluator(defaults: defaults)
        // Date-versioned: unparseable → unknown → falls through to major policy.
        let result = evaluator.evaluate([cask("zoom", "2024.10.1", "2024.11.1")], ledger: UpdateLedger(), now: referenceDate)
        XCTAssertEqual(result.needsApproval.count, 1)
    }

    // MARK: - Formula vs cask

    func testFormulaAndCaskUseSeparateDefaults() {
        var defaults = UpdatePolicyDefaults.safeDefaults
        defaults.caskPatch = .skip
        defaults.formulaPatch = .auto

        let evaluator = UpdateEvaluator(defaults: defaults)
        let result = evaluator.evaluate([
            cask("firefox", "120.0.0", "120.0.1"),
            formula("openssl", "3.0.0", "3.0.1")
        ], ledger: UpdateLedger(), now: referenceDate)

        XCTAssertEqual(result.autoInstall.map(\.name), ["openssl"])
        XCTAssertEqual(result.skipped.map(\.package.name), ["firefox"])
    }
}
