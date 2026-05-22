import XCTest
@testable import AutoBrew

final class SnapshotPathResolverTests: XCTestCase {
    func testReturnsStandardLibraryPaths() {
        let r = SnapshotPathResolver(bundleID: "com.example.app", home: URL(fileURLWithPath: "/Users/test"))
        let pathStrings = r.candidatePaths().map { $0.path }

        XCTAssertTrue(pathStrings.contains("/Users/test/Library/Preferences/com.example.app.plist"))
        XCTAssertTrue(pathStrings.contains("/Users/test/Library/Application Support/com.example.app"))
        XCTAssertTrue(pathStrings.contains("/Users/test/Library/Containers/com.example.app"))
        XCTAssertTrue(pathStrings.contains("/Users/test/Library/Saved Application State/com.example.app.savedState"))
    }

    func testIncludesGroupContainerRoot() {
        let r = SnapshotPathResolver(bundleID: "com.example.app", home: URL(fileURLWithPath: "/Users/test"))
        XCTAssertEqual(r.groupContainerSearchRoot.path, "/Users/test/Library/Group Containers")
    }

    /// Regression — a bundle ID ending in a generic segment like ".app" used to
    /// match every group container that happened to contain "app" as a
    /// substring (e.g. "apple" in "group.com.apple.stocks-news"), so AutoBrew
    /// tried to copy Apple's own group containers and hit a permission wall.
    /// The matcher must only fire on the identifying reverse-domain prefix.
    func testGroupContainerDoesNotMatchAppleContainersForGenericAppSuffix() throws {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: tmp) }
        let groupRoot = tmp.appendingPathComponent("Library/Group Containers")
        try FileManager.default.createDirectory(at: groupRoot, withIntermediateDirectories: true)
        for name in [
            "group.com.apple.stocks-news",
            "group.com.apple.weather",
            "ABCDE12345.com.usebruno.app",
            "group.com.usebruno.shared"
        ] {
            try FileManager.default.createDirectory(at: groupRoot.appendingPathComponent(name), withIntermediateDirectories: true)
        }

        let r = SnapshotPathResolver(bundleID: "com.usebruno.app", home: tmp)
        let matched = r.groupContainerPaths().map { $0.lastPathComponent }.sorted()

        XCTAssertFalse(matched.contains("group.com.apple.stocks-news"),
                       "Must not match Apple's Stocks group container for com.usebruno.app")
        XCTAssertFalse(matched.contains("group.com.apple.weather"),
                       "Must not match any Apple group container for com.usebruno.app")
        XCTAssertTrue(matched.contains("ABCDE12345.com.usebruno.app"),
                      "Team-ID-prefixed bruno group container must still match")
        XCTAssertTrue(matched.contains("group.com.usebruno.shared"),
                      "Standard bruno group container must still match")
    }

    /// Bundle IDs whose last segment is informative (e.g. "Safari" in
    /// "com.apple.Safari") should still match group containers that share that
    /// identifying suffix — we are only tightening the generic-suffix case.
    func testGroupContainerStillMatchesNonGenericLastSegment() throws {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: tmp) }
        let groupRoot = tmp.appendingPathComponent("Library/Group Containers")
        try FileManager.default.createDirectory(at: groupRoot, withIntermediateDirectories: true)
        for name in [
            "group.com.apple.Safari",
            "ABCDE12345.com.apple.Safari.SafeBrowsing",
            "group.com.apple.weather"
        ] {
            try FileManager.default.createDirectory(at: groupRoot.appendingPathComponent(name), withIntermediateDirectories: true)
        }

        let r = SnapshotPathResolver(bundleID: "com.apple.Safari", home: tmp)
        let matched = r.groupContainerPaths().map { $0.lastPathComponent }.sorted()

        XCTAssertTrue(matched.contains("group.com.apple.Safari"))
        XCTAssertTrue(matched.contains("ABCDE12345.com.apple.Safari.SafeBrowsing"))
        XCTAssertFalse(matched.contains("group.com.apple.weather"))
    }

    /// Some vendors register group containers as `<TeamID>.<AppName>` without
    /// the reverse domain. Long, non-generic last segments must still pick
    /// these up — short or generic suffixes do not, to keep the Apple-Stocks
    /// collision class closed.
    func testGroupContainerMatchesBareTeamIdSuffixWhenLastSegmentIsDistinctive() throws {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: tmp) }
        let groupRoot = tmp.appendingPathComponent("Library/Group Containers")
        try FileManager.default.createDirectory(at: groupRoot, withIntermediateDirectories: true)
        for name in [
            "ABCDE12345.Antinote",
            "ABCDE12345.OtherApp",
            "group.com.apple.weather"
        ] {
            try FileManager.default.createDirectory(at: groupRoot.appendingPathComponent(name), withIntermediateDirectories: true)
        }

        let r = SnapshotPathResolver(bundleID: "com.chabomakers.Antinote", home: tmp)
        let matched = r.groupContainerPaths().map { $0.lastPathComponent }.sorted()

        XCTAssertTrue(matched.contains("ABCDE12345.Antinote"),
                      "Bare TeamID + distinctive last segment must match")
        XCTAssertFalse(matched.contains("ABCDE12345.OtherApp"),
                       "Unrelated vendor container must not match")
        XCTAssertFalse(matched.contains("group.com.apple.weather"))
    }

    /// `identifyingSuffix` must refuse generic last segments outright.
    func testIdentifyingSuffixRejectsGenericLastSegments() {
        XCTAssertNil(SnapshotPathResolver.identifyingSuffix(for: "com.usebruno.app"),
                     ".app is generic and must not become a suffix match")
        XCTAssertNil(SnapshotPathResolver.identifyingSuffix(for: "com.example.iina"),
                     "Short last segments (<6 chars) must not become a suffix match")
        XCTAssertEqual(SnapshotPathResolver.identifyingSuffix(for: "com.chabomakers.Antinote"), "Antinote")
        XCTAssertEqual(SnapshotPathResolver.identifyingSuffix(for: "com.apple.Safari"), "Safari")
    }
}
