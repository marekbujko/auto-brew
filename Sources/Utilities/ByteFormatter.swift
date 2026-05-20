import Foundation

/// Locale-aware byte formatter using the Finder-style `.file` count (1024-based
/// labels: KB/MB/GB) so disk sizes match what users see in macOS itself.
enum ByteFormatter {
    static func string(_ bytes: Int64) -> String {
        let fmt = ByteCountFormatter()
        fmt.allowedUnits = [.useAll]
        fmt.countStyle = .file
        return fmt.string(fromByteCount: bytes)
    }
}
