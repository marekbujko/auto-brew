import Foundation

/// Compact, persisted form of a single GitHub release as fetched for
/// a pending-approval row. Stored on disk under
/// `~/Library/Application Support/AutoBrew/ReleaseNotes/<token>.json`
/// with a 7-day TTL so the next refresh of an unchanged cask hits
/// disk, not the GitHub API (which rate-limits unauthenticated
/// requests at 60/hour).
struct CaskReleaseNotes: Codable, Sendable, Equatable {
    let token: String
    let tag: String
    let publishedAt: Date?
    /// Raw Markdown body from the release. Rendered via
    /// `AttributedString(markdown:)` at display time.
    let bodyMarkdown: String
    let cachedAt: Date
}
