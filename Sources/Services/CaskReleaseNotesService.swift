import Foundation
import os

private let releaseNotesLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "ReleaseNotes")

/// Fetches per-cask release notes from GitHub for pending-approval
/// rows so the user has actual context — "what is going to change in
/// this update?" — before they approve.
///
/// Resolution heuristic:
/// 1. If the cask's `homepage` is `https://github.com/<owner>/<repo>`,
///    use those coordinates.
/// 2. Try `GET .../releases/tags/v<newVersion>` first.
/// 3. Fall back to `.../releases/latest` if step 2 returns 404.
/// 4. Cache the result on disk for 7 days.
///
/// Why on-disk cache + 7d TTL: GitHub's unauthenticated rate limit is
/// 60 req/hour per IP. A user with 20 pending approvals would
/// otherwise burn that budget on every PendingApprovalsView appear.
@MainActor
@Observable
final class CaskReleaseNotesService {
    static let shared = CaskReleaseNotesService()

    private let session: URLSessionProtocol
    private let cacheDir: URL
    private(set) var inFlight: Set<String> = []
    private(set) var memCache: [String: CaskReleaseNotes] = [:]

    /// Disk-cache TTL. After this window the next view-open re-fetches
    /// — GitHub Releases for popular projects change often enough that
    /// a stale week-old body is the right ceiling.
    static let cacheTTL: TimeInterval = 7 * 24 * 60 * 60

    init(session: URLSessionProtocol = URLSession.shared, cacheDirectory: URL? = nil) {
        self.session = session
        if let cacheDirectory {
            self.cacheDir = cacheDirectory
        } else {
            let base = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first!
                .appendingPathComponent("AutoBrew/ReleaseNotes", isDirectory: true)
            try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
            self.cacheDir = base
        }
    }

    func notes(for token: String) -> CaskReleaseNotes? {
        if let cached = memCache[token] { return cached }
        let disk = loadFromDisk(token: token)
        if let disk { memCache[token] = disk }
        return disk
    }

    func isFetching(_ token: String) -> Bool {
        inFlight.contains(token)
    }

    /// Idempotent fetch. Skips the network when a fresh disk-cached
    /// entry exists, or another fetch for the same token is already
    /// in flight.
    func prefetch(token: String, homepage: String, newVersion: String) async {
        guard let (owner, repo) = parseGitHubCoordinates(from: homepage) else {
            releaseNotesLogger.debug("Skipping \(token, privacy: .public) — homepage is not on github.com")
            return
        }
        if let cached = notes(for: token),
           Date().timeIntervalSince(cached.cachedAt) < Self.cacheTTL {
            return
        }
        if inFlight.contains(token) { return }
        inFlight.insert(token)
        defer { inFlight.remove(token) }

        let candidates = [
            "https://api.github.com/repos/\(owner)/\(repo)/releases/tags/v\(newVersion)",
            "https://api.github.com/repos/\(owner)/\(repo)/releases/tags/\(newVersion)",
            "https://api.github.com/repos/\(owner)/\(repo)/releases/latest"
        ]
        for urlString in candidates {
            guard let url = URL(string: urlString) else { continue }
            var request = URLRequest(url: url)
            request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
            request.setValue("AutoBrew", forHTTPHeaderField: "User-Agent")
            request.timeoutInterval = 8
            do {
                let (data, response) = try await session.data(for: request)
                guard let http = response as? HTTPURLResponse else { continue }
                if http.statusCode == 404 { continue }
                guard (200..<300).contains(http.statusCode) else { continue }
                guard let parsed = decode(data: data, token: token) else { continue }
                memCache[token] = parsed
                persistToDisk(parsed)
                return
            } catch {
                releaseNotesLogger.debug("Network error for \(token, privacy: .public): \(error.localizedDescription, privacy: .public)")
                continue
            }
        }
    }

    /// Internal: parses `https://github.com/<owner>/<repo>` (with or
    /// without trailing slash, optional `.git` suffix) into `(owner,
    /// repo)`. Returns nil for everything else — GitLab, vendor sites,
    /// sourcehut — so the caller knows not to bother with the GitHub
    /// API for that token.
    func parseGitHubCoordinates(from homepage: String) -> (owner: String, repo: String)? {
        guard let url = URL(string: homepage),
              url.host?.lowercased().hasSuffix("github.com") == true else { return nil }
        let parts = url.path.split(separator: "/", omittingEmptySubsequences: true)
        guard parts.count >= 2 else { return nil }
        var repo = String(parts[1])
        if repo.hasSuffix(".git") { repo.removeLast(4) }
        return (owner: String(parts[0]), repo: repo)
    }

    private func decode(data: Data, token: String) -> CaskReleaseNotes? {
        struct GHRelease: Decodable {
            let tag_name: String
            let published_at: String?
            let body: String?
        }
        guard let decoded = try? JSONDecoder().decode(GHRelease.self, from: data) else { return nil }
        let publishedAt = decoded.published_at.flatMap { ISO8601DateFormatter().date(from: $0) }
        return CaskReleaseNotes(
            token: token,
            tag: decoded.tag_name,
            publishedAt: publishedAt,
            bodyMarkdown: decoded.body ?? "",
            cachedAt: Date()
        )
    }

    private func cachePath(for token: String) -> URL {
        cacheDir.appendingPathComponent("\(token).json")
    }

    private func loadFromDisk(token: String) -> CaskReleaseNotes? {
        let url = cachePath(for: token)
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(CaskReleaseNotes.self, from: data) else { return nil }
        guard Date().timeIntervalSince(decoded.cachedAt) < Self.cacheTTL else { return nil }
        return decoded
    }

    private func persistToDisk(_ notes: CaskReleaseNotes) {
        guard let data = try? JSONEncoder().encode(notes) else { return }
        try? data.write(to: cachePath(for: notes.token), options: .atomic)
    }
}
