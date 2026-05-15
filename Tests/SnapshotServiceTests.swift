import XCTest
@testable import AutoBrew

final class SnapshotServiceTests: XCTestCase {
    private var tmp: URL!

    override func setUp() {
        super.setUp()
        tmp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try? FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
    }
    override func tearDown() { try? FileManager.default.removeItem(at: tmp); super.tearDown() }

    @MainActor
    func testCreateSnapshotCopiesExistingComponents() async throws {
        let home = tmp.appendingPathComponent("home")
        let bundleID = "com.example.test"
        let prefs = home.appendingPathComponent("Library/Preferences")
        try FileManager.default.createDirectory(at: prefs, withIntermediateDirectories: true)
        try "<plist></plist>".data(using: .utf8)!.write(to: prefs.appendingPathComponent("\(bundleID).plist"))

        let appSupport = home.appendingPathComponent("Library/Application Support/\(bundleID)")
        try FileManager.default.createDirectory(at: appSupport, withIntermediateDirectories: true)
        try "config".write(to: appSupport.appendingPathComponent("config.json"), atomically: true, encoding: .utf8)

        let svc = SnapshotService(storageRoot: tmp.appendingPathComponent("snapshots"), home: home)
        let snap = try await svc.createSnapshot(bundleID: bundleID, displayName: "Test", caskToken: "test-app", sourceAppVersion: "1.0")

        XCTAssertTrue(FileManager.default.fileExists(atPath: snap.manifestURL.path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: snap.dataDir.appendingPathComponent("Library/Preferences/\(bundleID).plist").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: snap.dataDir.appendingPathComponent("Library/Application Support/\(bundleID)/config.json").path))

        let manifestData = try Data(contentsOf: snap.manifestURL)
        let manifest = try JSONDecoder.snapshotDecoder().decode(SnapshotManifest.self, from: manifestData)
        XCTAssertEqual(manifest.bundleID, bundleID)
        XCTAssertEqual(manifest.caskToken, "test-app")
        XCTAssertGreaterThan(manifest.components.count, 0)
    }

    @MainActor
    func testListReturnsCreatedSnapshots() async throws {
        let home = tmp.appendingPathComponent("home")
        let prefs = home.appendingPathComponent("Library/Preferences")
        try FileManager.default.createDirectory(at: prefs, withIntermediateDirectories: true)
        try Data().write(to: prefs.appendingPathComponent("com.example.test.plist"))

        let svc = SnapshotService(storageRoot: tmp.appendingPathComponent("snapshots"), home: home)
        _ = try await svc.createSnapshot(bundleID: "com.example.test", displayName: "Test", caskToken: nil, sourceAppVersion: nil)

        let list = try svc.listSnapshots()
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.first?.bundleID, "com.example.test")
    }

    @MainActor
    func testDeleteSnapshot() async throws {
        let home = tmp.appendingPathComponent("home")
        let prefs = home.appendingPathComponent("Library/Preferences")
        try FileManager.default.createDirectory(at: prefs, withIntermediateDirectories: true)
        try Data().write(to: prefs.appendingPathComponent("com.example.del.plist"))

        let svc = SnapshotService(storageRoot: tmp.appendingPathComponent("snapshots"), home: home)
        let snap = try await svc.createSnapshot(bundleID: "com.example.del", displayName: "Del", caskToken: nil, sourceAppVersion: nil)

        XCTAssertTrue(FileManager.default.fileExists(atPath: snap.bundleURL.path))
        try svc.deleteSnapshot(snap)
        XCTAssertFalse(FileManager.default.fileExists(atPath: snap.bundleURL.path))
    }
}
