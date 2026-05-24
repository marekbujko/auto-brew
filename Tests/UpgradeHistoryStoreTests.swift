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
                               snapshot: UUID(), succeeded: true))

        let second = UpgradeHistoryStore(fileURL: url)
        XCTAssertEqual(second.entries.count, 1)
        XCTAssertEqual(second.entries.first?.token, "vscode")
        XCTAssertEqual(second.entries.first?.fromVersion, "1.90.0")
        XCTAssertEqual(second.entries.first?.toVersion, "1.91.0")
        XCTAssertNotNil(second.entries.first?.snapshotID)
    }

    @MainActor
    func testNewestEntryIsFirst() throws {
        let url = try makeTempFile()
        defer { try? FileManager.default.removeItem(at: url) }

        let store = UpgradeHistoryStore(fileURL: url)
        let older = makeEntry(token: "firefox", from: "120", to: "121",
                              at: Date(timeIntervalSinceNow: -3600),
                              snapshot: nil, succeeded: true)
        let newer = makeEntry(token: "vlc", from: "3.0.20", to: "3.0.21",
                              at: Date(),
                              snapshot: nil, succeeded: true)
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
                               snapshot: nil, succeeded: true))
        store.append(makeEntry(token: "recent", from: "1", to: "2",
                               at: Date(timeIntervalSinceNow: -3 * 86_400),
                               snapshot: nil, succeeded: true))

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
                               snapshot: nil, succeeded: true))
        store.prune(olderThanDays: 0)
        XCTAssertEqual(store.entries.count, 1, "prune(0) must not delete anything")
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
        succeeded: Bool
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
            succeeded: succeeded
        )
    }
}
