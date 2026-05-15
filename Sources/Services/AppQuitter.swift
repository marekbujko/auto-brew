import AppKit
import Foundation

@MainActor
enum AppQuitter {
    static func quit(bundleID: String, timeout: TimeInterval = 5.0) async throws {
        let running = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
        guard !running.isEmpty else { return }
        for app in running {
            app.terminate()
        }

        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            let still = NSRunningApplication.runningApplications(withBundleIdentifier: bundleID)
            if still.isEmpty { return }
            try await Task.sleep(for: .milliseconds(200))
        }
        for app in NSRunningApplication.runningApplications(withBundleIdentifier: bundleID) {
            _ = app.forceTerminate()
        }
    }
}
