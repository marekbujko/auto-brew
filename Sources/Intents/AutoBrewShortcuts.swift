import AppIntents

/// Registers AutoBrew's three intents so they show up in Shortcuts,
/// Spotlight and Siri without the user wiring anything by hand. The
/// `phrases` are the natural-language activators Siri matches against;
/// `\(.applicationName)` is required and gets replaced by "AutoBrew"
/// in the actual phrase.
///
/// Note: AppIntents only allows AppEntity or AppEnum parameters to be
/// interpolated into phrase templates. The `token` parameters on
/// InstallCaskIntent and SnapshotAppIntent are plain String values and
/// therefore cannot appear in Siri phrases — the user fills them in
/// interactively inside Shortcuts.
///
/// Known limitation: because AutoBrew sets `LSUIElement = true`, the
/// system only discovers these shortcuts after the app has been
/// launched at least once. That happens automatically for any user who
/// has the menu-bar icon visible.
struct AutoBrewShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: InstallCaskIntent(),
            phrases: [
                "Install a cask with \(.applicationName)",
                "Install a Homebrew cask with \(.applicationName)"
            ],
            shortTitle: "Install Cask",
            systemImageName: "shippingbox"
        )

        AppShortcut(
            intent: SnapshotAppIntent(),
            phrases: [
                "Snapshot an app with \(.applicationName)",
                "Back up an app with \(.applicationName)"
            ],
            shortTitle: "Snapshot App",
            systemImageName: "camera.on.rectangle"
        )

        AppShortcut(
            intent: RollBackLastUpgradeIntent(),
            phrases: [
                "Roll back the last upgrade with \(.applicationName)",
                "Undo the last \(.applicationName) upgrade"
            ],
            shortTitle: "Roll Back Upgrade",
            systemImageName: "arrow.uturn.backward"
        )
    }
}
