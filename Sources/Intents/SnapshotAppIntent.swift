import AppIntents
import Foundation

/// Shortcut for "snapshot the user data of cask X right now." Resolves
/// the cask token to a bundle ID via `InstalledAppsStore` (refreshing
/// once if empty) and runs the same `SnapshotService.createSnapshot`
/// path the menu-bar Snapshots view uses. Returns the snapshot's UUID
/// string so the user can chain it into another shortcut (e.g. share
/// the path, copy to a cloud folder).
struct SnapshotAppIntent: AppIntent {
    static let title: LocalizedStringResource = "Snapshot App Data"
    static let description = IntentDescription("Capture a transactional snapshot of an app's user data through AutoBrew.")
    static let openAppWhenRun: Bool = false

    @Parameter(
        title: "Cask Token",
        description: "The Homebrew cask token of the app to snapshot (the same token shown in BrewStore)."
    )
    var token: String

    static var parameterSummary: some ParameterSummary {
        Summary("Snapshot user data of \(\.$token)")
    }

    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let trimmed = token.trimmingCharacters(in: .whitespaces)
        guard trimmed.range(of: #"^[a-zA-Z0-9][a-zA-Z0-9._-]*$"#, options: .regularExpression) != nil else {
            throw AutoBrewIntentError.invalidCaskToken(trimmed)
        }

        if InstalledAppsStore.shared.apps.isEmpty {
            await InstalledAppsStore.shared.refresh()
        }
        let apps = InstalledAppsStore.shared.apps
        guard let app = apps.first(where: { ($0.caskToken ?? "").lowercased() == trimmed.lowercased() }) else {
            throw AutoBrewIntentError.caskNotInstalled(trimmed)
        }

        let snapshot = try await SnapshotService.shared.createSnapshot(
            bundleID: app.bundleID,
            displayName: app.displayName,
            caskToken: trimmed,
            sourceAppVersion: app.version
        )
        return .result(value: snapshot.id.uuidString)
    }
}
