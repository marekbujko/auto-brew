import XCTest
@testable import AutoBrew

final class UpdateLedgerTests: XCTestCase {
    func testFirstTouchRecordsNow() {
        var ledger = UpdateLedger()
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        let result = ledger.touch(kind: .cask, token: "firefox", version: "120.0", now: now)
        XCTAssertEqual(result, now)
        XCTAssertEqual(ledger.entries.count, 1)
    }

    func testRepeatedTouchKeepsOriginalDate() {
        var ledger = UpdateLedger()
        let firstTime = Date(timeIntervalSince1970: 1_700_000_000)
        _ = ledger.touch(kind: .cask, token: "firefox", version: "120.0", now: firstTime)
        let later = firstTime.addingTimeInterval(86_400 * 5)  // five days later
        let result = ledger.touch(kind: .cask, token: "firefox", version: "120.0", now: later)
        XCTAssertEqual(result, firstTime)
    }

    func testNewVersionResetsClock() {
        var ledger = UpdateLedger()
        let firstTime = Date(timeIntervalSince1970: 1_700_000_000)
        _ = ledger.touch(kind: .cask, token: "firefox", version: "120.0", now: firstTime)
        let later = firstTime.addingTimeInterval(86_400 * 5)
        let result = ledger.touch(kind: .cask, token: "firefox", version: "121.0", now: later)
        XCTAssertEqual(result, later)
        XCTAssertEqual(ledger.entries.count, 1)
        XCTAssertNil(ledger.entries[UpdateLedger.key(kind: .cask, token: "firefox", version: "120.0")])
    }

    func testCaskAndFormulaWithSameTokenDoNotCollide() {
        var ledger = UpdateLedger()
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        _ = ledger.touch(kind: .cask, token: "node", version: "20.0.0", now: now)
        _ = ledger.touch(kind: .formula, token: "node", version: "20.0.0", now: now)
        XCTAssertEqual(ledger.entries.count, 2)
    }

    func testPurgeKeepsActiveKeysOnly() {
        var ledger = UpdateLedger()
        let now = Date()
        _ = ledger.touch(kind: .cask, token: "firefox", version: "120.0", now: now)
        _ = ledger.touch(kind: .cask, token: "vscode", version: "1.83.0", now: now)
        _ = ledger.touch(kind: .cask, token: "slack", version: "4.30.0", now: now)

        ledger.purge(keeping: [
            UpdateLedger.key(kind: .cask, token: "firefox", version: "120.0"),
            UpdateLedger.key(kind: .cask, token: "vscode", version: "1.83.0")
        ])

        XCTAssertEqual(ledger.entries.count, 2)
        XCTAssertNil(ledger.entries[UpdateLedger.key(kind: .cask, token: "slack", version: "4.30.0")])
    }

    func testStoreRoundTripsToDisk() throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("UpdateLedgerTests-\(UUID().uuidString).json")
        defer { try? FileManager.default.removeItem(at: tmp) }

        let store = MainActor.assumeIsolated { UpdateLedgerStore(fileURL: tmp) }
        let now = Date(timeIntervalSince1970: 1_700_000_000)
        let result = MainActor.assumeIsolated { store.touch(kind: .cask, token: "firefox", version: "120.0", now: now) }
        XCTAssertEqual(result, now)

        let reloaded = MainActor.assumeIsolated { UpdateLedgerStore(fileURL: tmp) }
        let again = MainActor.assumeIsolated { reloaded.touch(kind: .cask, token: "firefox", version: "120.0", now: now.addingTimeInterval(86_400)) }
        XCTAssertEqual(again, now)
    }
}
