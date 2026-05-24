import XCTest
@testable import AutoBrew

final class BrewUpgradeOutcomeParserTests: XCTestCase {
    func testEmptyTokensReturnsEmptyMap() {
        let result = BrewUpgradeOutcomeParser.parse(stdout: "anything at all", tokens: [])
        XCTAssertTrue(result.isEmpty)
    }

    func testSingleSuccessfulCask() {
        let stdout = """
        ==> Upgrading 1 outdated package:
        vscode 1.90.0 -> 1.91.0

        ==> Upgrading vscode
        ==> Downloading https://example.com/vscode.dmg
        ==> Backing App Visual Studio Code.app to '/Applications/...'
        ==> Purging files for version 1.90.0 of Cask vscode
        🍺  vscode was successfully upgraded!
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["vscode"])
        XCTAssertEqual(result["vscode"], .succeeded)
    }

    func testFailedCaskHasErrorLineInSection() {
        let stdout = """
        ==> Upgrading firefox
        ==> Downloading https://example.com/firefox.dmg
        Error: Download failed: SHA mismatch
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["firefox"])
        XCTAssertEqual(result["firefox"], .failed)
    }

    /// Realistic batch: vscode succeeds, firefox throws inside its own
    /// section. Each token must land in the correct bucket; neither one's
    /// outcome may leak across to the other.
    func testMixedBatchAttributesIndependently() {
        let stdout = """
        ==> Upgrading 2 outdated packages:
        vscode 1.90.0 -> 1.91.0
        firefox 120 -> 121

        ==> Upgrading vscode
        ==> Downloading https://example.com/vscode.dmg
        🍺  vscode was successfully upgraded!

        ==> Upgrading firefox
        ==> Downloading https://example.com/firefox.dmg
        Error: Download failed: SHA mismatch
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["vscode", "firefox"])
        XCTAssertEqual(result["vscode"], .succeeded)
        XCTAssertEqual(result["firefox"], .failed)
    }

    /// A failure in one section must not contaminate a later section that
    /// has no error line and no success marker. The later token stays
    /// `.attempted` — `not failed` is not the same as `succeeded`.
    func testFailureDoesNotBleedIntoNextSection() {
        let stdout = """
        ==> Upgrading firefox
        Error: download bombed
        ==> Upgrading slack
        (no markers in this section)
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["firefox", "slack"])
        XCTAssertEqual(result["firefox"], .failed)
        XCTAssertEqual(result["slack"], .attempted)
    }

    /// Each cask's success line lives at the end of its own section in
    /// real brew output — both must land in .succeeded.
    func testEachSectionAttributedIndependently() {
        let stdout = """
        ==> Upgrading firefox
        ==> Downloading mirror...
        🍺  firefox was successfully upgraded!
        ==> Upgrading slack
        ==> Downloading mirror...
        🍺  slack was successfully upgraded!
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["firefox", "slack"])
        XCTAssertEqual(result["firefox"], .succeeded)
        XCTAssertEqual(result["slack"], .succeeded)
    }

    /// A cask that prints another requested token's "success" marker
    /// inside its own section must not be able to spoof that token's
    /// outcome. firefox's section here contains a forged slack-success
    /// line; slack itself never got a marker, so the parser must keep
    /// slack at .attempted.
    func testForeignSuccessMarkerInSectionDoesNotSpoof() {
        let stdout = """
        ==> Upgrading firefox
        🍺  slack was successfully upgraded!
        🍺  firefox was successfully upgraded!
        ==> Upgrading slack
        Error: download bombed
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["firefox", "slack"])
        XCTAssertEqual(result["firefox"], .succeeded, "firefox's real success marker must still register")
        XCTAssertEqual(result["slack"], .failed, "slack must keep its real failure even though firefox's section forged a slack-success line")
    }

    /// Without the bottle emoji prefix, a "<token> was successfully
    /// upgraded!" line is not a brew success marker — it's freeform text
    /// brew never emits in that shape. Must not promote to .succeeded.
    func testSuccessMarkerRequiresBottleEmoji() {
        let stdout = """
        ==> Upgrading firefox
        firefox was successfully upgraded!
        ==> Upgrading slack
        ✓ slack was successfully upgraded!
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["firefox", "slack"])
        XCTAssertEqual(result["firefox"], .attempted)
        XCTAssertEqual(result["slack"], .attempted)
    }

    /// A token whose section both shows an Error AND a later success line
    /// is treated as `.succeeded` — brew sometimes prints harmless `Error:`
    /// lines during the install hook that don't actually fail the cask.
    /// The 🍺 marker is the authoritative signal.
    func testSuccessMarkerOverridesEarlierErrorInSection() {
        let stdout = """
        ==> Upgrading slack
        Error: some-non-fatal-warning-shaped-like-error
        🍺  slack was successfully upgraded!
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["slack"])
        XCTAssertEqual(result["slack"], .succeeded)
    }

    /// Tokens that were requested but never showed up in the output (brew
    /// skipped them silently — e.g. already at the requested version) must
    /// default to `.attempted`, never `.succeeded`.
    func testRequestedButUnmentionedTokenIsAttempted() {
        let stdout = """
        ==> Upgrading vscode
        🍺  vscode was successfully upgraded!
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["vscode", "alfred"])
        XCTAssertEqual(result["vscode"], .succeeded)
        XCTAssertEqual(result["alfred"], .attempted)
    }

    /// Output that mentions an unrelated token (e.g. brew log noise) must
    /// not be misattributed to one of our requested tokens.
    func testUnrelatedHeaderDoesNotMisattribute() {
        let stdout = """
        ==> Upgrading firefox
        Error: blew up
        ==> Upgrading randomother
        Error: also blew up
        """
        let result = BrewUpgradeOutcomeParser.parse(stdout: stdout, tokens: ["firefox", "slack"])
        XCTAssertEqual(result["firefox"], .failed)
        XCTAssertEqual(result["slack"], .attempted, "slack was never present in the output — must not inherit randomother's failure")
    }
}
