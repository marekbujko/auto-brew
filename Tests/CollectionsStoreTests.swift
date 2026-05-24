import XCTest
@testable import AutoBrew

final class CollectionsStoreTests: XCTestCase {
    @MainActor
    func testEmptyStoreStartsEmpty() throws {
        let url = try makeTempURL()
        defer { try? FileManager.default.removeItem(at: url) }
        let store = CollectionsStore(fileURL: url)
        XCTAssertTrue(store.collections.isEmpty)
    }

    @MainActor
    func testCreateAndPersistAcrossReinit() throws {
        let url = try makeTempURL()
        defer { try? FileManager.default.removeItem(at: url) }

        let first = CollectionsStore(fileURL: url)
        _ = first.create(name: "Dev", tokens: ["firefox", "visual-studio-code"])

        let second = CollectionsStore(fileURL: url)
        XCTAssertEqual(second.collections.count, 1)
        XCTAssertEqual(second.collections.first?.name, "Dev")
        XCTAssertEqual(second.collections.first?.tokens, ["firefox", "visual-studio-code"])
    }

    @MainActor
    func testTokensSortedOnInsert() throws {
        let url = try makeTempURL()
        defer { try? FileManager.default.removeItem(at: url) }
        let store = CollectionsStore(fileURL: url)
        let c = store.create(name: "Mixed", tokens: ["zoom", "alfred", "monosnap"])
        XCTAssertEqual(store.collections.first(where: { $0.id == c.id })?.tokens,
                       ["alfred", "monosnap", "zoom"])
    }

    @MainActor
    func testAddRemoveTokenIdempotent() throws {
        let url = try makeTempURL()
        defer { try? FileManager.default.removeItem(at: url) }
        let store = CollectionsStore(fileURL: url)
        let c = store.create(name: "Dev")
        store.addToken("vscode", to: c.id)
        store.addToken("vscode", to: c.id)
        XCTAssertEqual(store.collections.first(where: { $0.id == c.id })?.tokens, ["vscode"],
                       "Adding the same token twice should not duplicate it")
        store.removeToken("vscode", from: c.id)
        XCTAssertEqual(store.collections.first(where: { $0.id == c.id })?.tokens, [])
    }

    @MainActor
    func testExportImportRoundtripGetsFreshID() throws {
        let storeURL = try makeTempURL()
        let exportURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("\(UUID().uuidString).autobrewcollection")
        defer {
            try? FileManager.default.removeItem(at: storeURL)
            try? FileManager.default.removeItem(at: exportURL)
        }
        let store = CollectionsStore(fileURL: storeURL)
        let original = store.create(name: "Dev", tokens: ["firefox"])
        try store.export(original.id, to: exportURL)

        let imported = try store.import(from: exportURL)
        XCTAssertEqual(imported.name, "Dev")
        XCTAssertEqual(imported.tokens, ["firefox"])
        XCTAssertNotEqual(imported.id, original.id,
                          "Imported collection must get a fresh UUID so it cannot clobber the source")
    }

    @MainActor
    func testDeleteRemoves() throws {
        let url = try makeTempURL()
        defer { try? FileManager.default.removeItem(at: url) }
        let store = CollectionsStore(fileURL: url)
        let c = store.create(name: "Dev")
        store.delete(c.id)
        XCTAssertTrue(store.collections.isEmpty)
    }

    private func makeTempURL() throws -> URL {
        let dir = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("Collections.json")
    }
}
