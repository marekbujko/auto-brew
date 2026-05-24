import Foundation

/// Per-cask outcome of a `brew upgrade --cask` invocation. `BrewManager`
/// reports only the aggregate process exit status; the parser walks
/// `brew`'s stdout to attribute success and failure markers to individual
/// tokens. Anything we can't classify cleanly stays `.attempted` so the UI
/// never claims certainty it doesn't have.
enum CaskUpgradeOutcome: String, Sendable, Codable, Equatable {
    /// The `🍺  <token> was successfully upgraded!` marker was present.
    case succeeded
    /// An `Error:` line was emitted in this cask's section of the output.
    case failed
    /// Neither marker found — typically because brew skipped the cask
    /// (already at the requested version) or the output format changed.
    /// Treated as "we don't know" rather than implicitly succeeded.
    case attempted
}
