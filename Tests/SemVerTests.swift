import XCTest
@testable import AutoBrew

final class SemVerTests: XCTestCase {
    func testParseSimpleSemVer() {
        XCTAssertEqual(SemVer.parse("1.2.3"), SemVer(major: 1, minor: 2, patch: 3))
    }

    func testParseTwoComponentVersion() {
        XCTAssertEqual(SemVer.parse("1.2"), SemVer(major: 1, minor: 2, patch: 0))
    }

    func testParseStripsLeadingV() {
        XCTAssertEqual(SemVer.parse("v2.4.0"), SemVer(major: 2, minor: 4, patch: 0))
        XCTAssertEqual(SemVer.parse("V2.4.0"), SemVer(major: 2, minor: 4, patch: 0))
    }

    func testParseStripsBuildSuffix() {
        XCTAssertEqual(SemVer.parse("1.2.3+build.5"), SemVer(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(SemVer.parse("1.2.3-beta"), SemVer(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(SemVer.parse("1.2.3-rc.1"), SemVer(major: 1, minor: 2, patch: 3))
        XCTAssertEqual(SemVer.parse("1.2.3_4"), SemVer(major: 1, minor: 2, patch: 3))
    }

    func testParseSparkleStyleVersion() {
        // Apps signed with Sparkle often use "version,build" — keep the version part.
        XCTAssertEqual(SemVer.parse("1.2.3,4567"), SemVer(major: 1, minor: 2, patch: 3))
    }

    func testParseChromeStyleFourComponents() {
        // Chrome ships e.g. 117.0.5938.62 — we keep the first three segments.
        XCTAssertEqual(SemVer.parse("117.0.5938.62"), SemVer(major: 117, minor: 0, patch: 5938))
    }

    func testParseRejectsDateLikeVersions() {
        XCTAssertNil(SemVer.parse("2024.10.1"))
        XCTAssertNil(SemVer.parse("2025.1.15"))
        XCTAssertNil(SemVer.parse("2026.12.31"))
    }

    func testParseAcceptsNonDateBoundary() {
        // major=1999 is well below the date heuristic and stays parseable.
        XCTAssertEqual(SemVer.parse("1999.10.1"), SemVer(major: 1999, minor: 10, patch: 1))
        // major>=2000 with minor>12 isn't a plausible month → still parses.
        XCTAssertEqual(SemVer.parse("2024.13.1"), SemVer(major: 2024, minor: 13, patch: 1))
    }

    func testParseRejectsGarbage() {
        XCTAssertNil(SemVer.parse(""))
        XCTAssertNil(SemVer.parse(" "))
        XCTAssertNil(SemVer.parse("abc"))
        XCTAssertNil(SemVer.parse("1"))
        XCTAssertNil(SemVer.parse(".."))
        XCTAssertNil(SemVer.parse("a.b.c"))
    }

    func testComparable() {
        XCTAssertLessThan(SemVer(major: 1, minor: 2, patch: 3), SemVer(major: 1, minor: 2, patch: 4))
        XCTAssertLessThan(SemVer(major: 1, minor: 2, patch: 3), SemVer(major: 1, minor: 3, patch: 0))
        XCTAssertLessThan(SemVer(major: 1, minor: 9, patch: 9), SemVer(major: 2, minor: 0, patch: 0))
        XCTAssertFalse(SemVer(major: 1, minor: 2, patch: 3) < SemVer(major: 1, minor: 2, patch: 3))
    }

    func testClassifierBumpTypes() {
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.2.3", to: "1.2.4"), .patch)
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.2.3", to: "1.3.0"), .minor)
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.2.3", to: "2.0.0"), .major)
    }

    func testClassifierReturnsPatchForRebuild() {
        // Same triple — Homebrew sometimes ships a respin under the same version.
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.2.3", to: "1.2.3"), .patch)
    }

    func testClassifierUnknownOnUnparseable() {
        XCTAssertEqual(VersionBumpClassifier.classify(from: "2024.10.1", to: "2024.10.2"), .unknown)
        XCTAssertEqual(VersionBumpClassifier.classify(from: "abc", to: "1.0.0"), .unknown)
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.0.0", to: "abc"), .unknown)
    }

    func testClassifierMixesStrippedSuffixes() {
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.2.3-beta", to: "1.2.4"), .patch)
        XCTAssertEqual(VersionBumpClassifier.classify(from: "1.2.3,100", to: "1.2.3,101"), .patch)
        XCTAssertEqual(VersionBumpClassifier.classify(from: "v1.2.3", to: "v2.0.0"), .major)
    }
}
