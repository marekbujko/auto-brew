import XCTest
@testable import AutoBrew

final class CaskReleaseNotesServiceTests: XCTestCase {
    @MainActor
    func testParseGitHubCoordinatesHappyPath() {
        let svc = CaskReleaseNotesService(session: ReleaseNotesMockSession())
        let parsed = svc.parseGitHubCoordinates(from: "https://github.com/microsoft/vscode")
        XCTAssertEqual(parsed?.owner, "microsoft")
        XCTAssertEqual(parsed?.repo, "vscode")
    }

    @MainActor
    func testParseGitHubCoordinatesStripsDotGit() {
        let svc = CaskReleaseNotesService(session: ReleaseNotesMockSession())
        let parsed = svc.parseGitHubCoordinates(from: "https://github.com/owner/repo.git")
        XCTAssertEqual(parsed?.repo, "repo")
    }

    @MainActor
    func testParseGitHubCoordinatesNilForNonGitHub() {
        let svc = CaskReleaseNotesService(session: ReleaseNotesMockSession())
        XCTAssertNil(svc.parseGitHubCoordinates(from: "https://gitlab.com/owner/repo"))
        XCTAssertNil(svc.parseGitHubCoordinates(from: "https://example.com/something"))
        XCTAssertNil(svc.parseGitHubCoordinates(from: "not a url at all"))
    }

    @MainActor
    func testPrefetchTagsThenCachesOnDisk() async throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let session = ReleaseNotesMockSession()
        let body = "## What's new\n\n- Faster startup\n- Bug fixes"
        session.respond(
            to: URL(string: "https://api.github.com/repos/microsoft/vscode/releases/tags/v1.95.0")!,
            status: 200,
            json: "{\"tag_name\":\"v1.95.0\",\"published_at\":\"2026-05-20T10:00:00Z\",\"body\":\"\(body.replacingOccurrences(of: "\n", with: "\\n"))\"}"
        )

        let svc = CaskReleaseNotesService(session: session, cacheDirectory: tmp)
        await svc.prefetch(token: "vscode",
                           homepage: "https://github.com/microsoft/vscode",
                           newVersion: "1.95.0")

        let notes = svc.notes(for: "vscode")
        XCTAssertEqual(notes?.tag, "v1.95.0")
        XCTAssertEqual(notes?.bodyMarkdown.contains("Faster startup"), true)

        // Cache file should exist on disk.
        XCTAssertTrue(FileManager.default.fileExists(atPath: tmp.appendingPathComponent("vscode.json").path))
    }

    @MainActor
    func testPrefetchFallsBackToLatestOnTagMiss() async throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let session = ReleaseNotesMockSession()
        // Both tag attempts return 404; only /latest answers.
        session.respond(to: URL(string: "https://api.github.com/repos/o/r/releases/tags/v2.0.0")!, status: 404, json: "{}")
        session.respond(to: URL(string: "https://api.github.com/repos/o/r/releases/tags/2.0.0")!, status: 404, json: "{}")
        session.respond(to: URL(string: "https://api.github.com/repos/o/r/releases/latest")!,
                        status: 200,
                        json: "{\"tag_name\":\"v2.0.0\",\"published_at\":null,\"body\":\"From latest\"}")

        let svc = CaskReleaseNotesService(session: session, cacheDirectory: tmp)
        await svc.prefetch(token: "t", homepage: "https://github.com/o/r", newVersion: "2.0.0")

        XCTAssertEqual(svc.notes(for: "t")?.tag, "v2.0.0")
        XCTAssertEqual(svc.notes(for: "t")?.bodyMarkdown, "From latest")
    }

    @MainActor
    func testPrefetchSkipsForNonGitHubHomepage() async throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let session = ReleaseNotesMockSession()
        let svc = CaskReleaseNotesService(session: session, cacheDirectory: tmp)
        await svc.prefetch(token: "vlc",
                           homepage: "https://videolan.org",
                           newVersion: "3.0.0")
        XCTAssertNil(svc.notes(for: "vlc"))
        XCTAssertTrue(session.allRequests.isEmpty,
                      "Non-GitHub homepage must not hit the GitHub API")
    }

    private func makeTempDir() throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        return url
    }
}

final class ReleaseNotesMockSession: URLSessionProtocol, @unchecked Sendable {
    private struct Stub { var status: Int; var json: Data }
    private let lock = NSLock()
    private var stubs: [URL: Stub] = [:]
    private(set) var allRequests: [URLRequest] = []

    func respond(to url: URL, status: Int, json: String) {
        lock.withLock { stubs[url] = Stub(status: status, json: Data(json.utf8)) }
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let (stub, url): (Stub?, URL?) = lock.withLock {
            allRequests.append(request)
            return (request.url.flatMap { stubs[$0] }, request.url)
        }
        guard let url, let stub else { throw URLError(.fileDoesNotExist) }
        let response = HTTPURLResponse(url: url, statusCode: stub.status, httpVersion: "HTTP/1.1", headerFields: nil)!
        return (stub.json, response)
    }
}
