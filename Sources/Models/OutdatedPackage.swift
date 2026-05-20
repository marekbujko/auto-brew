import Foundation

/// One row parsed from `brew outdated --json=v2`. `isCask` decides whether the
/// upgrade goes through `brew upgrade` or `brew upgrade --cask`.
struct OutdatedPackage: Identifiable, Sendable {
    let name: String
    let currentVersion: String
    let newVersion: String
    let isCask: Bool

    var id: String { name }
}
