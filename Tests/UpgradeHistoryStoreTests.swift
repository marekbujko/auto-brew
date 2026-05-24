import XCTest
@testable import AutoBrew

final class UpgradeHistoryStoreTests: XCTestCase {
    @MainActor
    func testEmptyStoreReturnsEmpty() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }
        let store = UpgradeHistoryStore(fileURL: url)
        XCTAssertTrue(store.entries.isEmpty)
    }

    @MainActor
    func testAppendPersistsAcrossReinit() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let first = UpgradeHistoryStore(fileURL: url)
        first.append(makeEntry(token: "vscode", from: "1.90.0", to: "1.91.0",
                               snapshot: UUID(), outcome: .succeeded))

        let second = UpgradeHistoryStore(fileURL: url)
        XCTAssertEqual(second.entries.count, 1)
        XCTAssertEqual(second.entries.first?.token, "vscode")
        XCTAssertEqual(second.entries.first?.fromVersion, "1.90.0")
        XCTAssertEqual(second.entries.first?.toVersion, "1.91.0")
        XCTAssertEqual(second.entries.first?.outcome, .succeeded)
        XCTAssertNotNil(second.entries.first?.snapshotID)
    }

    @MainActor
    func testNewestEntryIsFirst() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let store = UpgradeHistoryStore(fileURL: url)
        let older = makeEntry(token: "firefox", from: "120", to: "121",
                              at: Date(timeIntervalSinceNow: -3600),
                              snapshot: nil, outcome: .succeeded)
        let newer = makeEntry(token: "vlc", from: "3.0.20", to: "3.0.21",
                              at: Date(),
                              snapshot: nil, outcome: .succeeded)
        store.append(older)
        store.append(newer)

        XCTAssertEqual(store.entries.first?.token, "vlc")
        XCTAssertEqual(store.entries.last?.token, "firefox")
    }

    @MainActor
    func testPruneRemovesEntriesOlderThanWindow() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let store = UpgradeHistoryStore(fileURL: url)
        store.append(makeEntry(token: "veryOld", from: "1", to: "2",
                               at: Date(timeIntervalSinceNow: -91 * 86_400),
                               snapshot: nil, outcome: .succeeded))
        store.append(makeEntry(token: "recent", from: "1", to: "2",
                               at: Date(timeIntervalSinceNow: -3 * 86_400),
                               snapshot: nil, outcome: .succeeded))

        store.prune(olderThanDays: 30)

        XCTAssertEqual(store.entries.count, 1)
        XCTAssertEqual(store.entries.first?.token, "recent")
    }

    @MainActor
    func testPruneZeroDaysIsNoop() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let store = UpgradeHistoryStore(fileURL: url)
        store.append(makeEntry(token: "vscode", from: "1", to: "2",
                               at: Date(timeIntervalSinceNow: -1000 * 86_400),
                               snapshot: nil, outcome: .succeeded))
        store.prune(olderThanDays: 0)
        XCTAssertEqual(store.entries.count, 1, "prune(0) must not delete anything")
    }

    @MainActor
    func testOutcomePersistsAllThreeStates() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let store = UpgradeHistoryStore(fileURL: url)
        store.append(makeEntry(token: "a", from: "1", to: "2", snapshot: nil, outcome: .succeeded))
        store.append(makeEntry(token: "b", from: "1", to: "2", snapshot: nil, outcome: .failed))
        store.append(makeEntry(token: "c", from: "1", to: "2", snapshot: nil, outcome: .attempted))

        let reread = UpgradeHistoryStore(fileURL: url)
        // Newest-first, so order is c, b, a.
        XCTAssertEqual(reread.entries.map(\.outcome), [.attempted, .failed, .succeeded])
    }

    /// A user's UpgradeHistory.json written under the old `succeeded:Bool`
    /// schema must still decode. Dropping their history on first launch of
    /// a new build is a worse experience than carrying a slightly-fuzzy
    /// "we don't know" outcome forward.
    @MainActor
    func testLegacySucceededFieldDecodesIntoOutcome() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let legacyJSON = #"""
        [
          {
            "id" : "11111111-1111-1111-1111-111111111111",
            "timestamp" : "2025-12-01T12:00:00Z",
            "token" : "vscode",
            "displayName" : "Visual Studio Code",
            "fromVersion" : "1.90.0",
            "toVersion" : "1.91.0",
            "bundleID" : "com.microsoft.VSCode",
            "snapshotID" : "22222222-2222-2222-2222-222222222222",
            "succeeded" : true
          },
          {
            "id" : "33333333-3333-3333-3333-333333333333",
            "timestamp" : "2025-12-02T12:00:00Z",
            "token" : "firefox",
            "displayName" : "Firefox",
            "fromVersion" : "120",
            "toVersion" : "121",
            "bundleID" : null,
            "snapshotID" : null,
            "succeeded" : false
          }
        ]
        """#
        try legacyJSON.data(using: .utf8)!.write(to: url, options: .atomic)

        let store = UpgradeHistoryStore(fileURL: url)
        XCTAssertEqual(store.entries.count, 2, "Legacy rows must survive the schema change")
        XCTAssertEqual(store.entries.first(where: { $0.token == "vscode" })?.outcome, .succeeded)
        XCTAssertEqual(store.entries.first(where: { $0.token == "firefox" })?.outcome, .failed)
    }

    @MainActor
    func testCorruptedFileFallsBackToEmpty() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        try "not valid json {{{".data(using: .utf8)!.write(to: url, options: .atomic)
        let store = UpgradeHistoryStore(fileURL: url)
        XCTAssertTrue(store.entries.isEmpty, "Corrupted history must not crash the store")
    }

    // MARK: helpers

    private func makeTempFile() throws -> URL {
        let dir = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("UpgradeHistory.json")
    }

    private func makeEntry(
        token: String,
        from: String,
        to: String,
        at timestamp: Date = Date(),
        bundleID: String? = "co.test.\(UUID().uuidString.prefix(6))",
        snapshot: UUID?,
        outcome: CaskUpgradeOutcome
    ) -> UpgradeHistoryEntry {
        UpgradeHistoryEntry(
            id: UUID(),
            timestamp: timestamp,
            token: token,
            displayName: token.capitalized,
            fromVersion: from,
            toVersion: to,
            bundleID: bundleID,
            snapshotID: snapshot,
            outcome: outcome
        )
    }
}
