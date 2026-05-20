import Foundation

/// Hides Apple's built-in apps from listings so the user doesn't see Safari,
/// Notes, FaceTime, … alongside their installed third-party apps. The
/// `com.apple.` prefix covers every shipping system app reliably; using a
/// broader heuristic (e.g. path under `/System/`) would also catch managed
/// apps we do care about.
enum AppleAppFilter {
    static func isAppleSystemApp(bundleID: String) -> Bool {
        bundleID.hasPrefix("com.apple.")
    }
}
