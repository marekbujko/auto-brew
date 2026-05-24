import AppIntents
import Foundation

/// Shortcuts/Spotlight/Siri entry point for `brew install --cask <token>`.
/// The intent runs in whatever process Shortcuts spins up; the install
/// itself still goes through `BrewInstaller` on the MainActor so the
/// existing retry-with-`--force` fallback and lock semantics apply
/// unchanged.
///
/// The token is validated against the same grammar `autobrew://install/`
/// uses — defense in depth for an externally-supplied value, even though
/// brew itself does not interpret the token through a shell.
struct InstallCaskIntent: AppIntent {
    static let title: LocalizedStringResource = "Install Homebrew Cask"
    static let description = IntentDescription("Install a cask from the Homebrew catalog through AutoBrew.")
    static let openAppWhenRun: Bool = false

    @Parameter(
        title: "Cask Token",
        description: "The Homebrew cask token (e.g. 'visual-studio-code', 'firefox')."
    )
    var token: String

    static var parameterSummary: some ParameterSummary {
        Summary("Install \(\.$token)")
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        let trimmed = token.trimmingCharacters(in: .whitespaces)
        guard trimmed.range(of: #"^[a-zA-Z0-9][a-zA-Z0-9._-]*$"#, options: .regularExpression) != nil else {
            throw AutoBrewIntentError.invalidCaskToken(trimmed)
        }
        try await BrewInstaller().install(token: trimmed)
        return .result()
    }
}
