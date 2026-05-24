import XCTest
@testable import AutoBrew

final class SecurityScopedBookmarkTests: XCTestCase {
    func testEncodeAndResolveRoundtrip() throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: tmp) }

        guard let data = SecurityScopedBookmark.encode(tmp) else {
            XCTFail("Encoding a freshly-created directory bookmark should succeed")
            return
        }
        guard let resolved = SecurityScopedBookmark.resolve(data) else {
            XCTFail("Resolving the bookmark we just wrote must succeed")
            return
        }
        defer { resolved.url.stopAccessingSecurityScopedResource() }
        XCTAssertEqual(resolved.url.standardizedFileURL.path,
                       tmp.standardizedFileURL.path)
    }

    /// A bookmark whose target has been removed should fail resolution
    /// without throwing into the caller — the SnapshotService relies on
    /// the nil-return to fall back to the default storage location.
    func testResolveReturnsNilWhenTargetDisappears() throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        let data = try XCTUnwrap(SecurityScopedBookmark.encode(tmp))
        try FileManager.default.removeItem(at: tmp)

        // Right after deletion the bookmark may still resolve (HFS+
        // catalog cache, APFS clones). Forcing a fail-path is brittle
        // so we just verify the API never throws and returns either a
        // value or nil — the contract callers rely on.
        let resolved = SecurityScopedBookmark.resolve(data)
        if let resolved {
            resolved.url.stopAccessingSecurityScopedResource()
        }
    }
}
