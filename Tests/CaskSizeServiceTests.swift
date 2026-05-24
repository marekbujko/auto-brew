import XCTest
@testable import AutoBrew

final class CaskSizeServiceTests: XCTestCase {
    private static let downloadURL = URL(string: "https://cdn.example.com/firefox.dmg")!
    private static let token = "firefox"

    @MainActor
    func testPrefetchCachesContentLength() async throws {
        let session = SizeMockSession()
        session.respond(to: Self.downloadURL, status: 200, contentLength: "104857600")
        let svc = CaskSizeService(session: session)

        await svc.prefetch(token: Self.token, url: Self.downloadURL)
        XCTAssertEqual(svc.size(for: Self.token), 104857600)
        XCTAssertFalse(svc.isFetching(Self.token), "in-flight set must clear after the prefetch returns")
        XCTAssertEqual(session.requests(for: Self.downloadURL).count, 1)
    }

    @MainActor
    func testSecondPrefetchUsesCache() async throws {
        let session = SizeMockSession()
        session.respond(to: Self.downloadURL, status: 200, contentLength: "12345")
        let svc = CaskSizeService(session: session)

        await svc.prefetch(token: Self.token, url: Self.downloadURL)
        await svc.prefetch(token: Self.token, url: Self.downloadURL)

        XCTAssertEqual(svc.size(for: Self.token), 12345)
        XCTAssertEqual(session.requests(for: Self.downloadURL).count, 1,
                       "Second prefetch must not hit the network when the cache is warm")
    }

    @MainActor
    func testMissingContentLengthLeavesSizeNil() async throws {
        let session = SizeMockSession()
        session.respond(to: Self.downloadURL, status: 200, contentLength: nil)
        let svc = CaskSizeService(session: session)

        await svc.prefetch(token: Self.token, url: Self.downloadURL)
        XCTAssertNil(svc.size(for: Self.token), "Servers that hide Content-Length must surface as 'unknown', not '0 bytes'")
    }

    @MainActor
    func testHTTP500LeavesSizeNil() async throws {
        let session = SizeMockSession()
        session.respond(to: Self.downloadURL, status: 500, contentLength: "9999")
        let svc = CaskSizeService(session: session)

        await svc.prefetch(token: Self.token, url: Self.downloadURL)
        XCTAssertNil(svc.size(for: Self.token), "Error responses must not cache the bogus length they reported")
    }

    @MainActor
    func testRequestUsesHeadMethod() async throws {
        let session = SizeMockSession()
        session.respond(to: Self.downloadURL, status: 200, contentLength: "1")
        let svc = CaskSizeService(session: session)
        await svc.prefetch(token: Self.token, url: Self.downloadURL)
        let recorded = session.requests(for: Self.downloadURL).first
        XCTAssertEqual(recorded?.httpMethod, "HEAD", "Size lookup must avoid downloading the body")
    }
}

/// In-process URLSessionProtocol stub for size lookups. Records each
/// request so a test can assert on the HTTP method and the call count.
final class SizeMockSession: URLSessionProtocol, @unchecked Sendable {
    private struct Stub {
        var status: Int
        var contentLength: String?
    }

    private let lock = NSLock()
    private var stubs: [URL: Stub] = [:]
    private var seen: [URL: [URLRequest]] = [:]

    func respond(to url: URL, status: Int, contentLength: String?) {
        lock.lock(); defer { lock.unlock() }
        stubs[url] = Stub(status: status, contentLength: contentLength)
    }

    func requests(for url: URL) -> [URLRequest] {
        lock.lock(); defer { lock.unlock() }
        return seen[url] ?? []
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let url = request.url else { throw URLError(.badURL) }
        let stub: Stub? = {
            lock.lock(); defer { lock.unlock() }
            seen[url, default: []].append(request)
            return stubs[url]
        }()
        guard let stub else { throw URLError(.fileDoesNotExist) }
        var headers: [String: String] = [:]
        if let value = stub.contentLength {
            headers["Content-Length"] = value
        }
        let response = HTTPURLResponse(
            url: url,
            statusCode: stub.status,
            httpVersion: "HTTP/1.1",
            headerFields: headers
        )!
        return (Data(), response)
    }
}
