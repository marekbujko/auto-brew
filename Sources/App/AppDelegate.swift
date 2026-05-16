import AppKit
import os
import SwiftUI

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

        Task { @MainActor in
            await NotificationManager.shared.requestAuthorization()
            if BrewManager.shared.isHomebrewInstalled {
                SchedulerService.shared.start()
            }
            logger.info("AutoBrew started (homebrew installed: \(BrewManager.shared.isHomebrewInstalled))")
        }
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
            if let token = url.pathComponents.dropFirst().first, !token.isEmpty {
                Task { try? await BrewInstaller().install(token: token) }
                requestOpenWindow()
            }
        default:
            requestOpenWindow()
        }
    }

    private func requestOpenWindow() {
        NSApp.activate(ignoringOtherApps: true)
        NotificationCenter.default.post(name: .openBrewStationWindow, object: nil)
    }
}

extension Notification.Name {
    static let openBrewStationWindow = Notification.Name("openBrewStationWindow")
}
