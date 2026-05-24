import Foundation
import os

private let bookmarkLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Bookmark")

/// Persists user-picked directory access across app launches.
///
/// We are **not** sandboxed (direct-distribution app), so technically
/// the home directory bookmark could be a plain `URL`. But the user
/// can point AutoBrew at an *external* drive — and external drives
/// remount with fresh device IDs after replug. A security-scoped
/// bookmark survives that round trip because macOS resolves the
/// volume by UUID + path inside the volume, then re-grants access.
/// Plain `URL.path` would silently break after the first
/// disconnect/reconnect.
///
/// API stays nil-safe: encoding failures and stale bookmarks both
/// surface as `nil`, the caller falls back to the default storage
/// location and posts a notification.
enum SecurityScopedBookmark {
    static func encode(_ url: URL) -> Data? {
        do {
            return try url.bookmarkData(
                options: [.withSecurityScope],
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
        } catch {
            bookmarkLogger.error("Failed to encode bookmark for \(url.path, privacy: .public): \(error.localizedDescription, privacy: .public)")
            return nil
        }
    }

    /// Resolves a previously-encoded bookmark and starts the
    /// security scope. Returns nil when the volume is no longer
    /// reachable; callers are expected to fall back to the default
    /// location and inform the user.
    ///
    /// `stale: true` signals macOS believes the bookmark needs
    /// re-encoding — we still return the URL so storage works, but
    /// the caller should re-encode + re-persist afterwards.
    static func resolve(_ data: Data) -> (url: URL, stale: Bool)? {
        var isStale = false
        do {
            let url = try URL(
                resolvingBookmarkData: data,
                options: [.withSecurityScope],
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            )
            guard url.startAccessingSecurityScopedResource() else {
                bookmarkLogger.warning("Could not start security scope on \(url.path, privacy: .public)")
                return nil
            }
            return (url, isStale)
        } catch {
            bookmarkLogger.warning("Bookmark resolution failed: \(error.localizedDescription, privacy: .public)")
            return nil
        }
    }
}
