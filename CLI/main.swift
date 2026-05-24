import Foundation
import AppKit

/// `autobrew` — thin CLI that routes user commands to the running
/// AutoBrew menu-bar app through the `autobrew://` URL scheme. The
/// app's existing handlers (AppDelegate) apply the same security
/// checks and confirmation prompts the URL scheme already enforces —
/// the CLI does not bypass any of them.
///
/// Why a URL-relay rather than a service-reusing tool: AutoBrew's
/// services are `@MainActor` singletons that own files under
/// `~/Library/Application Support/AutoBrew/`. A second process
/// reading + writing those files in parallel with the running GUI
/// would risk corrupting the History + Pending stores. Going through
/// URL scheme keeps the GUI as the single writer and avoids that
/// entire class of bug.

// File is named `main.swift` so top-level code is the entry point —
// `@main` cannot coexist with top-level statements in the same module.

struct AutoBrewCLI {
    func run(command: String, args: [String]) -> Int32 {
        switch command {
        case "open":
            return dispatch(url: "autobrew://open")
        case "install":
            guard let token = args.first, isValidCaskToken(token) else {
                printError("install requires a valid cask token, e.g. `autobrew install firefox`")
                return EXIT_FAILURE
            }
            return dispatch(url: "autobrew://install/\(token)")
        case "rollback":
            return dispatch(url: "autobrew://rollback")
        case "run-now":
            return dispatch(url: "autobrew://run-now")
        case "version", "--version", "-v":
            printVersion()
            return EXIT_SUCCESS
        case "help", "--help", "-h":
            printUsage()
            return EXIT_SUCCESS
        default:
            printError("unknown command: \(command)")
            printUsage()
            return EXIT_FAILURE
        }
    }

    /// Whitelist mirroring Homebrew's own cask-token grammar — same
    /// regex as the AppDelegate URL handler uses for `autobrew://
    /// install/<token>`. Defense in depth even though brew itself
    /// never sees the value through a shell.
    func isValidCaskToken(_ token: String) -> Bool {
        token.range(of: #"^[a-zA-Z0-9][a-zA-Z0-9._-]*$"#, options: .regularExpression) != nil
    }

    private func dispatch(url string: String) -> Int32 {
        guard let url = URL(string: string) else {
            printError("could not build URL for \(string)")
            return EXIT_FAILURE
        }
        NSWorkspace.shared.open(url)
        return EXIT_SUCCESS
    }

    private func printUsage() {
        let stderr = FileHandle.standardError
        let text = """
        autobrew — thin CLI that drives the AutoBrew menu-bar app.

        USAGE:
          autobrew <command> [arguments]

        COMMANDS:
          open                    Bring the BrewStore window forward.
          install <cask-token>    Ask AutoBrew to install a Homebrew cask.
                                  Token is validated against
                                  ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ and a
                                  confirmation prompt appears in AutoBrew
                                  before the install runs.
          rollback                Roll back the most recent failed cask
                                  upgrade whose pre-upgrade snapshot is
                                  still on disk.
          run-now                 Trigger an immediate brew update + upgrade
                                  + cleanup cycle.
          version                 Print the bundled CLI version.
          help                    Show this text.

        All commands are URL-scheme triggers — AutoBrew must be installed
        and running for them to take effect.
        """
        stderr.write(Data(text.utf8))
        stderr.write(Data("\n".utf8))
    }

    private func printVersion() {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "unknown"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "unknown"
        print("autobrew-cli \(version) (\(build))")
    }

    private func printError(_ message: String) {
        let stderr = FileHandle.standardError
        stderr.write(Data("error: \(message)\n".utf8))
    }
}

// Entry point.
let cli = AutoBrewCLI()
let args = Array(CommandLine.arguments.dropFirst())
guard let command = args.first else {
    _ = cli.run(command: "help", args: [])
    exit(EXIT_FAILURE)
}
let status = cli.run(command: command, args: Array(args.dropFirst()))
exit(status)
