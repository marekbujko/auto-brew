import Foundation

/// Minimal SemVer that's lenient enough for what Homebrew throws at us.
/// Strips a leading `v`, drops anything after the first `,`/`-`/`+`/`_`
/// (build numbers, prereleases) and takes the first three numeric segments.
struct SemVer: Equatable, Comparable, Sendable {
    let major: Int
    let minor: Int
    let patch: Int

    static func parse(_ string: String) -> SemVer? {
        let trimmed = string.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return nil }

        // Strip optional leading "v"
        let withoutPrefix: String
        if let first = trimmed.first, first == "v" || first == "V" {
            withoutPrefix = String(trimmed.dropFirst())
        } else {
            withoutPrefix = trimmed
        }

        // Stop at the first separator that introduces build/prerelease info.
        let cutSet = CharacterSet(charactersIn: ",-+_ ")
        let core = withoutPrefix.components(separatedBy: cutSet).first ?? ""
        guard !core.isEmpty else { return nil }

        let parts = core.split(separator: ".", omittingEmptySubsequences: false)
        guard parts.count >= 2 else { return nil }

        let nums = parts.compactMap { Int($0) }
        // Must have at least major + minor as integers; otherwise this isn't
        // a version we can reason about.
        guard nums.count >= 2 else { return nil }

        let major = nums[0]
        let minor = nums[1]
        let patch = nums.count >= 3 ? nums[2] : 0

        // Heuristic: `2024.10.1` looks like a date stamp, not a SemVer.
        // Treat those as unknown so the caller routes them through major.
        if major >= 2000 && (1...12).contains(minor) {
            return nil
        }

        return SemVer(major: major, minor: minor, patch: patch)
    }

    static func < (lhs: SemVer, rhs: SemVer) -> Bool {
        if lhs.major != rhs.major { return lhs.major < rhs.major }
        if lhs.minor != rhs.minor { return lhs.minor < rhs.minor }
        return lhs.patch < rhs.patch
    }
}

enum VersionBumpType: String, Codable, Sendable, Equatable {
    case patch
    case minor
    case major
    /// Either version didn't parse — caller should treat this as a major
    /// bump so it routes through approval rather than slipping past.
    case unknown
}

enum VersionBumpClassifier {
    static func classify(from current: String, to available: String) -> VersionBumpType {
        guard let c = SemVer.parse(current),
              let a = SemVer.parse(available) else { return .unknown }
        if a.major != c.major { return .major }
        if a.minor != c.minor { return .minor }
        if a.patch != c.patch { return .patch }
        // Same SemVer triple — usually a rebuild/respin. Treat as patch.
        return .patch
    }
}
