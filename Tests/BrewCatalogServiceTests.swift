import XCTest
@testable import AutoBrew

final class BrewCatalogServiceTests: XCTestCase {
    private static let casksJSON = #"[{"token":"firefox","name":["Firefox"],"desc":"Browser","homepage":"https://mozilla.org","url":"x","version":"1","artifacts":[]}]"#
    private static let analyticsJSON = #"{"category":"cask-install","total_items":1,"total_count":100,"items":[{"number":1,"cask":"firefox","count":"100"}]}"#

    private static let casksURL = URL(string: "https://formulae.brew.sh/api/cask.json")!
    private static let analyticsURL = URL(string: "https://formulae.brew.sh/api/analytics/cask-install/homebrew-cask/365d.json")!

    @MainActor
    func testFetchesAndCachesCatalog() async throws {
        let session = MockURLSession()
        session.respond(to: Self.casksURL,     with: Self.casksJSON,     etag: "cask-v1")
        session.respond(to: Self.analyticsURL, with: Self.analyticsJSON, etag: "ana-v1")

        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let svc = BrewCatalogService(session: session, cacheDirectory: tmp)
        try await svc.refresh()

        XCTAssertEqual(svc.casks.count, 1)
        XCTAssertEqual(svc.casks.first?.token, "firefox")
        XCTAssertEqual(svc.analytics?.installCount(for: "firefox"), 100)
        XCTAssertTrue(FileManager.default.fileExists(atPath: tmp.appendingPathComponent("cask.json").path))
        XCTAssertTrue(FileManager.default.fileExists(atPath: tmp.appendingPathComponent("etags.json").path))
    }

    @MainActor
    func testLoadsFromCacheWhenOffline() async throws {
        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let cached = #"[{"token":"vlc","name":["VLC"],"desc":null,"homepage":"https://x","url":"y","version":"1","artifacts":[]}]"#
        try cached.write(to: tmp.appendingPathComponent("cask.json"), atomically: true, encoding: .utf8)

        let svc = BrewCatalogService(session: MockURLSession(error: URLError(.notConnectedToInternet)),
                                     cacheDirectory: tmp)
        try await svc.loadCache()

        XCTAssertEqual(svc.casks.count, 1)
        XCTAssertEqual(svc.casks.first?.token, "vlc")
    }

    /// Second refresh sends If-None-Match and gets 304 back — in-memory state
    /// must stay valid and the cached payload bytes must not be re-decoded.
    @MainActor
    func testNotModifiedKeepsCachedState() async throws {
        let session = MockURLSession()
        session.respond(to: Self.casksURL,     with: Self.casksJSON,     etag: "cask-v1")
        session.respond(to: Self.analyticsURL, with: Self.analyticsJSON, etag: "ana-v1")

        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let svc = BrewCatalogService(session: session, cacheDirectory: tmp)
        try await svc.refresh()
        let firstRefreshDate = svc.lastRefresh
        XCTAssertNotNil(firstRefreshDate)

        // Drop the bodies so a 200 here would yield empty data and break the
        // decode — proves the second refresh really did short-circuit on 304.
        session.dropBodies()

        try await Task.sleep(nanoseconds: 10_000_000)
        try await svc.refresh()

        XCTAssertEqual(svc.casks.count, 1, "304 must not clear the in-memory catalog")
        XCTAssertEqual(svc.casks.first?.token, "firefox")
        XCTAssertEqual(svc.analytics?.installCount(for: "firefox"), 100)
        XCTAssertNotNil(svc.lastRefresh)
        XCTAssertGreaterThan(svc.lastRefresh!, firstRefreshDate!,
                             "lastRefresh must advance even when the server returned 304")
        XCTAssertEqual(session.requests(for: Self.casksURL).last?.value(forHTTPHeaderField: "If-None-Match"),
                       "cask-v1")
    }

    /// Mixed result: cask payload changes, analytics doesn't. Only the changed
    /// endpoint must be re-decoded; the unchanged one must keep its old state.
    @MainActor
    func testMixedNotModifiedRefreshesOnlyChangedEndpoint() async throws {
        let session = MockURLSession()
        session.respond(to: Self.casksURL,     with: Self.casksJSON,     etag: "cask-v1")
        session.respond(to: Self.analyticsURL, with: Self.analyticsJSON, etag: "ana-v1")

        let tmp = try makeTempDir()
        defer { try? FileManager.default.removeItem(at: tmp) }

        let svc = BrewCatalogService(session: session, cacheDirectory: tmp)
        try await svc.refresh()

        // Cask gets a new revision; analytics stays the same and will 304.
        let updatedCasksJSON = #"[{"token":"firefox","name":["Firefox"],"desc":"Browser","homepage":"https://mozilla.org","url":"x","version":"1","artifacts":[]},{"token":"vlc","name":["VLC"],"desc":null,"homepage":"https://x","url":"y","version":"1","artifacts":[]}]"#
        session.respond(to: Self.casksURL, with: updatedCasksJSON, etag: "cask-v2")
        // analytics unchanged: keeps its v1 etag — request with If-None-Match: ana-v1 → 304.

        try await svc.refresh()

        XCTAssertEqual(svc.casks.count, 2, "Changed endpoint must re-decode")
        XCTAssertEqual(svc.analytics?.installCount(for: "firefox"), 100, "Unchanged endpoint must keep old state")
    }

    private func makeTempDir() throws -> URL {
        let tmp = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        return tmp
    }
}

/// Minimal in-process URL session that records each request and replies with
/// a configured payload + ETag, returning 304 when the request carries an
/// `If-None-Match` header matching the stored ETag.
final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
    private struct Stub {
        var body: Data
        var etag: String?
    }

    private let lock = NSLock()
    private var stubs: [URL: Stub] = [:]
    private var seenRequests: [URL: [URLRequest]] = [:]
    private let presetError: Error?

    init(error: Error? = nil) {
        self.presetError = error
    }

    func respond(to url: URL, with body: String, etag: String?) {
        respond(to: url, with: Data(body.utf8), etag: etag)
    }

    func respond(to url: URL, with body: Data, etag: String?) {
        lock.lock(); defer { lock.unlock() }
        stubs[url] = Stub(body: body, etag: etag)
    }

    /// Wipes the payload bodies but keeps the ETags — used to assert that a
    /// second refresh really came back as 304 instead of silently re-decoding
    /// empty data.
    func dropBodies() {
        lock.lock(); defer { lock.unlock() }
        for url in stubs.keys {
            stubs[url]?.body = Data()
        }
    }

    func requests(for url: URL) -> [URLRequest] {
        lock.lock(); defer { lock.unlock() }
        return seenRequests[url] ?? []
    }

    private func recordAndFetch(url: URL, request: URLRequest) -> Stub? {
        lock.lock(); defer { lock.unlock() }
        seenRequests[url, default: []].append(request)
        return stubs[url]
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let presetError { throw presetError }
        guard let url = request.url else { throw URLError(.badURL) }

        let stub = recordAndFetch(url: url, request: request)

        guard let stub else { throw URLError(.fileDoesNotExist) }

        if let inm = request.value(forHTTPHeaderField: "If-None-Match"),
           let etag = stub.etag,
           inm == etag {
            let resp = HTTPURLResponse(url: url, statusCode: 304, httpVersion: nil, headerFields: nil)!
            return (Data(), resp)
        }

        var headers: [String: String] = [:]
        if let etag = stub.etag { headers["Etag"] = etag }
        let resp = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: headers)!
        return (stub.body, resp)
    }
}
