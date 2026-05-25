import XCTest
@testable import AutoBrew

final class SnapshotDiffTests: XCTestCase {
    @MainActor
    func testIdenticalSnapshotsProduceAllUnchanged() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let first = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "1"
        )
        let second = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "1"
        )

        let diff = try service.diff(first, second)
        XCTAssertTrue(diff.added.isEmpty)
        XCTAssertTrue(diff.removed.isEmpty)
        XCTAssertTrue(diff.changed.isEmpty)
        XCTAssertFalse(diff.unchanged.isEmpty, "Two snapshots of the same untouched state must produce unchanged pairs")
    }

    @MainActor
    func testModifiedFileSurfacesAsChanged() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let older = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "1"
        )

        // Mutate prefs between snapshots so the SHA differs.
        try "MUTATED PREFS".data(using: .utf8)!.write(to: env.prefsURL, options: .atomic)
        let newer = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "2"
        )

        let diff = try service.diff(older, newer)
        XCTAssertFalse(diff.changed.isEmpty, "Mutating a file between snapshots must produce a changed entry")
        XCTAssertTrue(diff.added.isEmpty)
        XCTAssertTrue(diff.removed.isEmpty)

        let prefsPair = diff.changed.first { $0.newComponent.originalPath.contains("Preferences") }
        XCTAssertNotNil(prefsPair, "The changed pair must reference the Preferences file")
        XCTAssertNotEqual(prefsPair?.oldComponent.sha256, prefsPair?.newComponent.sha256)
    }

    @MainActor
    func testNewFileSurfacesAsAdded() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let older = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "1"
        )

        // Create a brand-new Saved Application State directory between
        // snapshots — the resolver should pick it up the second time.
        let savedDir = env.home.appendingPathComponent("Library/Saved Application State/co.test.app.savedState",
                                                       isDirectory: true)
        try FileManager.default.createDirectory(at: savedDir, withIntermediateDirectories: true)
        try "window state".data(using: .utf8)!
            .write(to: savedDir.appendingPathComponent("window.plist"), options: .atomic)

        let newer = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "1"
        )

        let diff = try service.diff(older, newer)
        XCTAssertFalse(diff.added.isEmpty, "A new component must surface as added")
        XCTAssertTrue(diff.added.contains { $0.originalPath.contains("Saved Application State") })
    }

    @MainActor
    func testByteDeltaSignedForShrunkComponent() async throws {
        let env = try makeEnvironment()
        defer { try? FileManager.default.removeItem(at: env.root) }

        let service = SnapshotService(storageRoot: env.storage, home: env.home)
        let older = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "1"
        )

        try "SMALL".data(using: .utf8)!.write(to: env.prefsURL, options: .atomic)
        let newer = try await service.createSnapshot(
            bundleID: "co.test.app",
            displayName: "Test",
            caskToken: nil,
            sourceAppVersion: "2"
        )

        let diff = try service.diff(older, newer)
        let prefsPair = diff.changed.first { $0.newComponent.originalPath.contains("Preferences") }
        XCTAssertNotNil(prefsPair)
        if let pair = prefsPair {
            XCTAssertLessThan(pair.byteDelta, 0, "Newer prefs is smaller — delta must be negative")
        }
    }

    private struct Environment {
        let root: URL
        let storage: URL
        let home: URL
        let prefsURL: URL
    }

    private func makeEnvironment() throws -> Environment {
        let root = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        let storage = root.appendingPathComponent("storage")
        let home = root.appendingPathComponent("home")
        let prefs = home.appendingPathComponent("Library/Preferences")
        try FileManager.default.createDirectory(at: storage, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(at: prefs, withIntermediateDirectories: true)
        let prefsURL = prefs.appendingPathComponent("co.test.app.plist")
        try "ORIGINAL PREFS".data(using: .utf8)!.write(to: prefsURL, options: .atomic)
        return Environment(root: root, storage: storage, home: home, prefsURL: prefsURL)
    }
}
