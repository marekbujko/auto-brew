import Foundation

/// User-facing errors surfaced to Shortcuts/Siri. AppIntents shows the
/// `errorDescription` verbatim in the failure banner, so it must read
/// like a complete sentence and stay localized.
enum AutoBrewIntentError: LocalizedError {
    case invalidCaskToken(String)
    case caskNotInstalled(String)
    case noRollbackCandidate
    case snapshotMissingOnDisk
    case rollbackTargetMissingSnapshot(String)

    var errorDescription: String? {
        switch self {
        case .invalidCaskToken(let token):
            return String(localized: "“\(token)” is not a valid Homebrew cask token. Use letters, digits, dots, dashes or underscores.")
        case .caskNotInstalled(let token):
            return String(localized: "AutoBrew did not find an installed app managed by cask “\(token)”. Open BrewStore to confirm the cask is installed and reconciled.")
        case .noRollbackCandidate:
            return String(localized: "No failed cask upgrade with a live pre-upgrade snapshot was found in the history.")
        case .snapshotMissingOnDisk:
            return String(localized: "The pre-upgrade snapshot for this upgrade is no longer on disk — retention or a manual cleanup removed it.")
        case .rollbackTargetMissingSnapshot(let token):
            return String(localized: "The most recent history row for “\(token)” has no pre-upgrade snapshot to roll back to.")
        }
    }
}
