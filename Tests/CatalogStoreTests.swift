import XCTest
@testable import AutoBrew

final class CatalogStoreTests: XCTestCase {
    private func sampleCasks() -> [CaskCatalogEntry] {
        let json = """
        [
            {"token":"firefox","name":["Firefox"],"desc":"Browser","homepage":"x","url":"y","version":"1","artifacts":[]},
            {"token":"google-chrome","name":["Google Chrome"],"desc":"Chrome browser","homepage":"x","url":"y","version":"1","artifacts":[]},
            {"token":"vlc","name":["VLC"],"desc":"Media player","homepage":"x","url":"y","version":"1","artifacts":[]}
        ]
        """.data(using: .utf8)!
        return try! JSONDecoder().decode([CaskCatalogEntry].self, from: json)
    }

    @MainActor
    func testSearchByToken() {
        let store = CatalogStore()
        store.replaceAll(sampleCasks(), analytics: nil)
        store.searchQuery = "vlc"
        XCTAssertEqual(store.filtered.count, 1)
        XCTAssertEqual(store.filtered.first?.token, "vlc")
    }

    @MainActor
    func testSearchByName() {
        let store = CatalogStore()
        store.replaceAll(sampleCasks(), analytics: nil)
        store.searchQuery = "chrome"
        XCTAssertEqual(store.filtered.count, 1)
    }

    @MainActor
    func testSearchByDescription() {
        let store = CatalogStore()
        store.replaceAll(sampleCasks(), analytics: nil)
        store.searchQuery = "media"
        XCTAssertEqual(store.filtered.count, 1)
        XCTAssertEqual(store.filtered.first?.token, "vlc")
    }

    @MainActor
    func testEmptyQueryReturnsAll() {
        let store = CatalogStore()
        store.replaceAll(sampleCasks(), analytics: nil)
        store.searchQuery = ""
        XCTAssertEqual(store.filtered.count, 3)
    }
}
