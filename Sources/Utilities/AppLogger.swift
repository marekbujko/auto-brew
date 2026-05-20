import os

/// Single source of truth for the `os.Logger` subsystem. Matches the app's
/// bundle identifier so Console.app and `log stream` can filter on it cleanly.
enum AppLogger {
    static let subsystem = "za.co.digitalfreedom.AutoBrew"

    static func logger(category: String) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}
