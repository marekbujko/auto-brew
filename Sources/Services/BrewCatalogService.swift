import Foundation
import os

protocol URLSessionProtocol: Sendable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

/// Loads the full cask catalog and 365-day install analytics from
/// formulae.brew.sh and caches both to disk. We hit the HTTP API rather than
/// `brew search` — it's faster and exposes analytics the CLI doesn't.
///
/// `refresh()` is ETag-aware: the server returns 304 Not Modified when the
/// catalog hasn't changed, so the daily background refresh from BrewStoreWindow
/// stays cheap even though the underlying payloads are ~30 MB + ~17 MB.
@Observable
@MainActor
final class BrewCatalogService {
    static let shared = BrewCatalogService()

    private(set) var casks: [CaskCatalogEntry] = []
    private(set) var analytics: CaskAnalytics?
    private(set) var lastRefresh: Date?
    private(set) var isLoading: Bool = false
    private(set) var lastError: String?

    private let session: URLSessionProtocol
    private let cacheDir: URL
    private let logger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "BrewCatalog")

    private let casksURL = URL(string: "https://formulae.brew.sh/api/cask.json")!
    private let analyticsURL = URL(string: "https://formulae.brew.sh/api/analytics/cask-install/homebrew-cask/365d.json")!

    private struct CatalogETags: Codable {
        var cask: String?
        var analytics: String?
    }

    init(session: URLSessionProtocol = URLSession.shared, cacheDirectory: URL? = nil) {
        self.session = session
        if let cacheDirectory {
            self.cacheDir = cacheDirectory
        } else {
            let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            let dir = support.appendingPathComponent("AutoBrew/Catalog", isDirectory: true)
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
            self.cacheDir = dir
        }
    }

    private var caskCacheURL: URL      { cacheDir.appendingPathComponent("cask.json") }
    private var analyticsCacheURL: URL { cacheDir.appendingPathComponent("analytics.json") }
    private var etagsURL: URL          { cacheDir.appendingPathComponent("etags.json") }

    func refresh() async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            var etags = loadETags()
            let caskEtag = etags.cask
            let analyticsEtag = etags.analytics

            async let caskResult = conditionalFetch(casksURL, etag: caskEtag)
            async let analyticsResult = conditionalFetch(analyticsURL, etag: analyticsEtag)

            let casksFetched = try await caskResult
            let analyticsFetched = try await analyticsResult

            if let (caskBytes, newEtag) = casksFetched {
                let decoded = try await Task.detached {
                    try JSONDecoder().decode([CaskCatalogEntry].self, from: caskBytes)
                }.value
                try caskBytes.write(to: caskCacheURL, options: .atomic)
                casks = decoded
                etags.cask = newEtag
                logger.info("Cask catalog refreshed: \(decoded.count) entries")
            } else {
                logger.info("Cask catalog unchanged (304)")
            }

            if let (analyticsBytes, newEtag) = analyticsFetched {
                let decoded = try await Task.detached {
                    try JSONDecoder().decode(CaskAnalytics.self, from: analyticsBytes)
                }.value
                try analyticsBytes.write(to: analyticsCacheURL, options: .atomic)
                analytics = decoded
                etags.analytics = newEtag
                logger.info("Cask analytics refreshed")
            } else {
                logger.info("Cask analytics unchanged (304)")
            }

            // ETags are saved last — if either write above throws, the old ETags
            // stay on disk so the next refresh re-downloads instead of trusting
            // a 304 against a payload we never managed to persist.
            saveETags(etags)
            lastRefresh = Date()
            lastError = nil
        } catch {
            lastError = error.localizedDescription
            logger.error("Catalog refresh failed: \(error.localizedDescription)")
            throw error
        }
    }

    /// Returns `nil` when the server replied 304 Not Modified, so the caller
    /// keeps the current in-memory state untouched. Returns `(data, etag)` on
    /// any 2xx response; throws on 4xx/5xx so an HTML error page never
    /// overwrites a valid cache.
    private func conditionalFetch(_ url: URL, etag: String?) async throws -> (Data, String?)? {
        var req = URLRequest(url: url)
        if let etag, !etag.isEmpty {
            req.setValue(etag, forHTTPHeaderField: "If-None-Match")
        }
        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse else {
            return (data, nil)
        }
        if http.statusCode == 304 {
            return nil
        }
        guard (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse,
                           userInfo: [NSLocalizedDescriptionKey: "HTTP \(http.statusCode) for \(url.lastPathComponent)"])
        }
        let newEtag = http.value(forHTTPHeaderField: "Etag") ?? http.value(forHTTPHeaderField: "ETag")
        return (data, newEtag)
    }

    private func loadETags() -> CatalogETags {
        guard let data = try? Data(contentsOf: etagsURL),
              let etags = try? JSONDecoder().decode(CatalogETags.self, from: data) else {
            return CatalogETags()
        }
        return etags
    }

    private func saveETags(_ etags: CatalogETags) {
        guard let data = try? JSONEncoder().encode(etags) else { return }
        try? data.write(to: etagsURL, options: .atomic)
    }

    /// Startup fallback when there's no network. `lastRefresh` then reflects
    /// the cache file's mtime, not "now".
    func loadCache() async throws {
        guard FileManager.default.fileExists(atPath: caskCacheURL.path) else {
            throw NSError(domain: "BrewCatalog", code: 1, userInfo: [NSLocalizedDescriptionKey: "No cache"])
        }
        let modDate = (try? FileManager.default.attributesOfItem(atPath: caskCacheURL.path))?[.modificationDate] as? Date
        let caskFile = caskCacheURL
        let analyticsFile = analyticsCacheURL

        let (loadedCasks, loadedAnalytics) = try await Task.detached {
            let casksData = try Data(contentsOf: caskFile)
            let casks = try JSONDecoder().decode([CaskCatalogEntry].self, from: casksData)
            var analytics: CaskAnalytics?
            if FileManager.default.fileExists(atPath: analyticsFile.path) {
                let aData = try Data(contentsOf: analyticsFile)
                analytics = try? JSONDecoder().decode(CaskAnalytics.self, from: aData)
            }
            return (casks, analytics)
        }.value

        casks = loadedCasks
        analytics = loadedAnalytics
        lastRefresh = modDate
        logger.info("Loaded \(self.casks.count) casks from cache")
    }
}
