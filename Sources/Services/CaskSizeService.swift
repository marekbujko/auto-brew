import Foundation
import os

private let caskSizeLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "CaskSize")

/// On-demand `Content-Length` lookup for the DMG behind a cask. The
/// public Homebrew catalog (`formulae.brew.sh`) does not carry a size
/// field, so AutoBrew probes the actual download URL with an HTTP HEAD
/// request and shows the result in BrowseDetailView before the user
/// commits to an install.
///
/// Failures are intentionally quiet — a server that hides
/// `Content-Length`, refuses HEAD requests, or times out simply leaves
/// the size as "unknown" in the UI. An install button must never be
/// gated on this lookup.
@MainActor
@Observable
final class CaskSizeService {
    static let shared = CaskSizeService()

    /// Reuses the existing protocol from `BrewCatalogService`, so a test
    /// can drop in a mock here without writing a parallel abstraction.
    private let session: URLSessionProtocol

    private var cache: [String: Int64] = [:]
    private(set) var inFlight: Set<String> = []

    /// 5 s is plenty for a HEAD against a CDN-hosted DMG; longer would
    /// just hold a Spinner on the detail view past the point of
    /// usefulness.
    static let requestTimeout: TimeInterval = 5

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Cached size in bytes if the HEAD succeeded since the last app
    /// launch, otherwise nil. Treats unknown as a soft "not yet" so
    /// the view re-triggers a prefetch when needed.
    func size(for token: String) -> Int64? {
        cache[token]
    }

    func isFetching(_ token: String) -> Bool {
        inFlight.contains(token)
    }

    /// Idempotent: hits the network only when neither a cached value
    /// nor an in-flight request already exists for the token.
    func prefetch(token: String, url: URL) async {
        if cache[token] != nil || inFlight.contains(token) { return }
        inFlight.insert(token)
        defer { inFlight.remove(token) }

        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.timeoutInterval = Self.requestTimeout

        do {
            let (_, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse,
                  (200..<400).contains(http.statusCode) else { return }
            // Content-Length comes back as a string of digits in bytes;
            // anything non-positive (or chunked-transfer where the
            // header is absent) leaves the cache untouched and the UI
            // shows "unknown".
            guard let raw = http.value(forHTTPHeaderField: "Content-Length"),
                  let bytes = Int64(raw),
                  bytes > 0 else { return }
            cache[token] = bytes
        } catch {
            caskSizeLogger.debug("Size lookup failed for \(token, privacy: .public): \(error.localizedDescription, privacy: .public)")
        }
    }

}
