import XCTest
@testable import AutoBrew

final class SnapshotServiceSelectiveRestoreTests: XCTestCase {
    @MainActor
    func testRestoreWithSelectedSubsetTouchesOnlyThoseComponents() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let snapshot = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test App",
            caskToken: nil,
            sourceAppVersion: "1.0"
        )

        // Mutate both live files post-snapshot so we can tell which one
        // got rolled back and which one stayed.
        try "MUTATED PREFS".data(using: .utf8)!
            .write(to: env.prefsURL, options: .atomic)
        try "MUTATED CACHE".data(using: .utf8)!
            .write(to: env.cacheURL, options: .atomic)

        // Restore only the preferences component.
        let prefsRel = (try XCTUnwrap(loadManifestComponent(in: snapshot, matching: "Preferences"))).relativeArchivePath
        try await service.restoreSnapshot(snapshot,
                                          terminateApp: false,
                                          components: [prefsRel])

        let restoredPrefs = try String(contentsOf: env.prefsURL, encoding: .utf8)
        let untouchedCache = try String(contentsOf: env.cacheURL, encoding: .utf8)
        XCTAssertEqual(restoredPrefs, "ORIGINAL PREFS",
                       "Selected component should be back to its snapshot state")
        XCTAssertEqual(untouchedCache, "MUTATED CACHE",
                       "Unselected component must remain at its current live state")
    }

    @MainActor
    func testNilComponentsRestoresEverything() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let snapshot = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test App",
            caskToken: nil,
            sourceAppVersion: "1.0"
        )

        try "MUTATED PREFS".data(using: .utf8)!
            .write(to: env.prefsURL, options: .atomic)
        try "MUTATED CACHE".data(using: .utf8)!
            .write(to: env.cacheURL, options: .atomic)

        // nil = restore every component, preserves the original
        // all-or-nothing behaviour.
        try await service.restoreSnapshot(snapshot, terminateApp: false)

        XCTAssertEqual(try String(contentsOf: env.prefsURL, encoding: .utf8), "ORIGINAL PREFS")
        XCTAssertEqual(try String(contentsOf: env.cacheURL, encoding: .utf8), "ORIGINAL CACHE")
    }

    @MainActor
    func testEmptyComponentSetThrows() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let snapshot = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test App",
            caskToken: nil,
            sourceAppVersion: "1.0"
        )

        do {
            try await service.restoreSnapshot(snapshot,
                                              terminateApp: false,
                                              components: [])
            XCTFail("Empty selection should throw — better than silently restoring nothing")
        } catch {
            // Expected
        }
    }

    // MARK: helpers

    private struct Environment {
        let root: URL
        let storage: URL
        let home: URL
        let prefsURL: URL
        let cacheURL: URL
    }

    private func makeEnvironment() throws -> Environment {
        let root = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        let storage = root.appendingPathComponent("storage")
        let home = root.appendingPathComponent("home")
        let prefs = home.appendingPathComponent("Library/Preferences")
        let cache = home.appendingPathComponent("Library/Caches/co.test.app")
        try FileManager.default.createDirectory(at: storage, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: prefs, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: cache, withIntermediateDirectories: true)
        let prefsURL = prefs.appendingPathComponent("co.test.app.plist")
        let cacheURL = cache.appendingPathComponent("blob.bin")
        try "ORIGINAL PREFS".data(using: .utf8)!.write(to: prefsURL, options: .atomic)
        try "ORIGINAL CACHE".data(using: .utf8)!.write(to: cacheURL, options: .atomic)
        return Environment(root: root, storage: storage, home: home, prefsURL: prefsURL, cacheURL: cacheURL)
    }

    private func loadManifestComponent(in snapshot: AppSnapshot, matching keyword: String) throws -> SnapshotComponent? {
        let data = try Data(contentsOf: snapshot.manifestURL)
        let manifest = try JSONDecoder.snapshotDecoder().decode(SnapshotManifest.self, from: data)
        return manifest.components.first(where: { $0.relativeArchivePath.contains(keyword) || $0.originalPath.contains(keyword) })
    }
}
