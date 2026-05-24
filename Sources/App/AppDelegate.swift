import AppKit
import os
import SwiftUI

/// Application lifecycle owner. Three responsibilities live here because they
/// each need access to `NSApp` before any SwiftUI scene is on screen:
/// switching to accessory (menu-bar-only) activation, wiring the
/// `autobrew://` URL scheme, and kicking off the scheduler once Homebrew is
/// confirmed present.
@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let logger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "AppDelegate")

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        NSAppleEventManager.shared().setEventHandler(
            self,
            andSelector: #selector(handleURLEvent(_:replyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )

        SupportPromptStore.shared.ensureInstallDate()

        // The notification-action handler can fire before the scheduler is
        // ready, so wire it up synchronously before any async work starts.
        NotificationManager.shared.onReviewApprovalsRequested = { [weak self] in
            self?.openPendingApprovals()
        }

        Task { @MainActor in
            await NotificationManager.shared.requestAuthorization()
            if BrewManager.shared.isHomebrewInstalled {
                SchedulerService.shared.start()
            }
            logger.info("AutoBrew started (homebrew installed: \(BrewManager.shared.isHomebrewInstalled))")
        }
    }

    private func openPendingApprovals() {
        NSApp.activate(ignoringOtherApps: true)
        BrewStoreNavigation.shared.requestedSection = .pendingApprovals
        NotificationCenter.default.post(name: .openBrewStoreWindow, object: nil)
    }

    @objc func handleURLEvent(_ event: NSAppleEventDescriptor, replyEvent: NSAppleEventDescriptor) {
        guard let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue,
              let url = URL(string: urlString),
              url.scheme == "autobrew" else { return }
        logger.info("Handling URL: \(url.absoluteString, privacy: .public)")
        handle(url: url)
    }

    private func handle(url: URL) {
        switch url.host {
        case "open":
            requestOpenWindow()
        case "install":
            if let token = url.pathComponents.dropFirst().first,
               !token.isEmpty,
               isValidCaskToken(token) {
                Task {
                    await self.confirmAndInstall(token: token)
                }
                requestOpenWindow()
            } else {
                logger.warning("Rejected install URL with invalid token")
            }
        case "rollback":
            // Fires from the widget's Roll Back button. No additional
            // confirmation prompt: the widget is the user's own surface
            // and clicking the button is the explicit consent. The
            // scheduler's `rollbackUpgrade(forEntryID:)` does the work
            // through the same code path the failed-upgrade
            // notification uses.
            Task {
                await self.rollbackFromWidget()
            }
        case "run-now":
            // Fires from the widget's Run Now link. Same trust model
            // as `rollback` — the widget is the user's own surface,
            // clicking is the explicit consent. `triggerManualRun`
            // is reentrancy-safe via SchedulerService.pipelineInProgress
            // so a fast double-click doesn't queue parallel runs.
            Task {
                await SchedulerService.shared.triggerManualRun()
            }
        default:
            requestOpenWindow()
        }
    }

    /// Whitelist that mirrors Homebrew's own cask-token grammar. Keeps shell
    /// metacharacters out of the install pipeline even though we never go
    /// through a shell — defense in depth for an externally-supplied value.
    private func isValidCaskToken(_ token: String) -> Bool {
        token.range(of: #"^[a-zA-Z0-9][a-zA-Z0-9._-]*$"#, options: .regularExpression) != nil
    }

    /// Prompt the user before running brew install in response to an external
    /// `autobrew://install/<token>` request. Without this guard a webpage could
    /// silently trigger installs simply by linking to the URL scheme.
    @MainActor
    private func confirmAndInstall(token: String) async {
        let alert = NSAlert()
        alert.messageText = String(localized: "Install \(token) via Homebrew?")
        alert.informativeText = String(localized: "An external request asked to install the cask \"\(token)\". Approve only if you trust the source.")
        alert.alertStyle = .warning
        alert.addButton(withTitle: String(localized: "Install"))
        alert.addButton(withTitle: String(localized: "Cancel"))

        NSApp.activate(ignoringOtherApps: true)
        let response = alert.runModal()
        guard response == .alertFirstButtonReturn else {
            logger.info("User declined URL-scheme install of \(token, privacy: .public)")
            return
        }
        do {
            try await BrewInstaller().install(token: token)
        } catch {
            logger.error("URL-scheme install failed for '\(token, privacy: .public)': \(error.localizedDescription, privacy: .public)")
        }
    }

    private func requestOpenWindow() {
        NSApp.activate(ignoringOtherApps: true)
        NotificationCenter.default.post(name: .openBrewStoreWindow, object: nil)
    }

    /// Bridges the widget's `autobrew://rollback` tap to the scheduler.
    /// Activation brings AutoBrew to the foreground first so the
    /// confirmation alerts the rollback path may surface from
    /// `AppQuitter` are not lost behind the menu bar.
    @MainActor
    private func rollbackFromWidget() async {
        NSApp.activate(ignoringOtherApps: true)
        await SchedulerService.shared.rollbackMostRecentFailedUpgrade()
    }
}

extension Notification.Name {
    static let openBrewStoreWindow = Notification.Name("openBrewStoreWindow")
    static let openLegalWindow = Notification.Name("openLegalWindow")
}
