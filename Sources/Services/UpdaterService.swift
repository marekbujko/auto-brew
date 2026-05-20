import Foundation
import Sparkle

/// Thin Sparkle wrapper. Sparkle has to start early (`startingUpdater: true`)
/// so it can schedule background checks against the feed in Info.plist.
@MainActor
final class UpdaterService {
    static let shared = UpdaterService()

    let updaterController: SPUStandardUpdaterController

    var canCheckForUpdates: Bool {
        updaterController.updater.canCheckForUpdates
    }

    func checkForUpdates() {
        updaterController.checkForUpdates(nil)
    }

    private init() {
        updaterController = SPUStandardUpdaterController(
            startingUpdater: true,
            updaterDelegate: nil,
            userDriverDelegate: nil
        )
    }
}
