import Foundation

/// Reads free space on the volume that holds `~/Library`. Used by the
/// pre-upgrade-snapshot path to bail out when the disk would not have
/// room for the copy — better to skip the safety-net than to fill the
/// disk and break unrelated apps.
///
/// `volumeAvailableCapacityForImportantUsageKey` is the right key for
/// "non-purgeable space we really have access to" — Apple keeps a
/// purgeable cache the system can reclaim, but counting it would
/// over-promise. The capacity is in bytes.
enum DiskSpaceMonitor {
    /// Bytes available on the home-directory volume, or nil when the
    /// system refuses to answer (network mount, restricted sandbox).
    /// `nil` means "skip the check" rather than "no space" — better
    /// to attempt the snapshot than to silently disable the feature.
    static func availableBytes(home: URL = FileManager.default.homeDirectoryForCurrentUser) -> Int64? {
        let values = try? home.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
        guard let capacity = values?.volumeAvailableCapacityForImportantUsage else {
            return nil
        }
        return Int64(capacity)
    }

    /// Convenience: true when at least `minGB` are available, or when
    /// the API could not answer.
    static func hasAtLeast(_ minGB: Int, home: URL = FileManager.default.homeDirectoryForCurrentUser) -> Bool {
        guard let bytes = availableBytes(home: home) else { return true }
        return bytes >= Int64(minGB) * 1_073_741_824
    }
}
