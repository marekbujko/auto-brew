import XCTest
@testable import AutoBrew

final class WidgetStateWriterTests: XCTestCase {
    @MainActor
    func testWriteAndDecodeRoundtrip() throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let entry = WidgetState.UpgradeRow(
            id: UUID(),
            token: "vscode",
            displayName: "Visual Studio Code",
            fromVersion: "1.90.0",
            toVersion: "1.91.0",
            outcome: .succeeded,
            timestamp: Date(timeIntervalSinceReferenceDate: 800_000_000)
        )
        let candidateID = UUID()
        let state = WidgetState(
            pendingApprovals: 2,
            pendingSampleNames: ["vlc", "obsidian"],
            recentUpgrades: [entry],
            rollbackCandidateID: candidateID,
            updatedAt: Date(timeIntervalSinceReferenceDate: 800_001_000)
        )

        WidgetStateWriter.write(state: state, containerOverride: tmp)

        let url = tmp.appendingPathComponent(WidgetStateWriter.stateFilename)
        XCTAssertTrue(FileManager.default.fileExists(atPath: url.path))

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let raw = try Data(contentsOf: url)
        let decoded = try decoder.decode(WidgetState.self, from: raw)

        XCTAssertEqual(decoded.pendingApprovals, 2)
        XCTAssertEqual(decoded.pendingSampleNames, ["vlc", "obsidian"])
        XCTAssertEqual(decoded.recentUpgrades.count, 1)
        XCTAssertEqual(decoded.recentUpgrades.first?.outcome, .succeeded)
        XCTAssertEqual(decoded.rollbackCandidateID, candidateID)
    }

    @MainActor
    func testAllThreeOutcomesSerialise() throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let rows: [WidgetState.UpgradeRow] = [
            row("a", outcome: .succeeded),
            row("b", outcome: .failed),
            row("c", outcome: .attempted)
        ]
        let state = WidgetState(
            pendingApprovals: 0,
            pendingSampleNames: [],
            recentUpgrades: rows,
            rollbackCandidateID: nil,
            updatedAt: Date()
        )
        WidgetStateWriter.write(state: state, containerOverride: tmp)

        let url = tmp.appendingPathComponent(WidgetStateWriter.stateFilename)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(WidgetState.self, from: Data(contentsOf: url))
        XCTAssertEqual(decoded.recentUpgrades.map(\.outcome), [.succeeded, .failed, .attempted])
        XCTAssertNil(decoded.rollbackCandidateID)
    }

    /// Earlier writes must be replaced atomically, not merged. Without
    /// the .atomic option a concurrent reader could see a truncated
    /// state mid-write.
    @MainActor
    func testRepeatedWritesReplaceFile() throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let first = WidgetState(
            pendingApprovals: 3,
            pendingSampleNames: ["a", "b", "c"],
            recentUpgrades: [],
            rollbackCandidateID: nil,
            updatedAt: Date(timeIntervalSinceReferenceDate: 1)
        )
        WidgetStateWriter.write(state: first, containerOverride: tmp)

        let second = WidgetState(
            pendingApprovals: 0,
            pendingSampleNames: [],
            recentUpgrades: [],
            rollbackCandidateID: nil,
            updatedAt: Date(timeIntervalSinceReferenceDate: 2)
        )
        WidgetStateWriter.write(state: second, containerOverride: tmp)

        let url = tmp.appendingPathComponent(WidgetStateWriter.stateFilename)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(WidgetState.self, from: Data(contentsOf: url))
        XCTAssertEqual(decoded.pendingApprovals, 0, "Second write must overwrite first")
        XCTAssertTrue(decoded.pendingSampleNames.isEmpty)
    }

    @MainActor
    func testEmptyStateIsValid() throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        WidgetStateWriter.write(state: .empty, containerOverride: tmp)

        let url = tmp.appendingPathComponent(WidgetStateWriter.stateFilename)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(WidgetState.self, from: Data(contentsOf: url))
        XCTAssertEqual(decoded.pendingApprovals, 0)
        XCTAssertTrue(decoded.pendingSampleNames.isEmpty)
        XCTAssertTrue(decoded.recentUpgrades.isEmpty)
        XCTAssertNil(decoded.rollbackCandidateID)
    }

    // MARK: helpers

    private func makeTempDir() throws -> URL {
        let dir = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }

    private func row(_ token: String, outcome: CaskUpgradeOutcome) -> WidgetState.UpgradeRow {
        WidgetState.UpgradeRow(
            id: UUID(),
            token: token,
            displayName: token.capitalized,
            fromVersion: "1",
            toVersion: "2",
            outcome: outcome,
            timestamp: Date()
        )
    }
}
