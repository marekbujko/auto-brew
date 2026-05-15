import Foundation

enum AppleAppFilter {
    private static let blockedBundleIDs: Set<String> = [
        "com.apple.AddressBook", "com.apple.appstore", "com.apple.AppStore",
        "com.apple.ActivityMonitor", "com.apple.AudioMIDISetup", "com.apple.Automator",
        "com.apple.Calculator", "com.apple.calendar", "com.apple.iCal",
        "com.apple.CharacterPalette", "com.apple.Chess", "com.apple.Clock",
        "com.apple.ColorSyncUtility", "com.apple.Compressor", "com.apple.Console",
        "com.apple.Contacts", "com.apple.Dashboard", "com.apple.Dictionary",
        "com.apple.DigitalColorMeter", "com.apple.DigitalColourMeter",
        "com.apple.DirectoryUtility", "com.apple.DiskInventory", "com.apple.DiskUtility",
        "com.apple.dock", "com.apple.dt.Xcode", "com.apple.FaceTime",
        "com.apple.finder", "com.apple.Freeform", "com.apple.GameCenter",
        "com.apple.garageband", "com.apple.Grapher", "com.apple.Home",
        "com.apple.iMovie", "com.apple.Instruments", "com.apple.iTunes",
        "com.apple.keyboard", "com.apple.KeychainAccess", "com.apple.Keynote",
        "com.apple.Localization", "com.apple.logic.pro", "com.apple.Magnifier",
        "com.apple.Mail", "com.apple.MainStage3", "com.apple.Maps",
        "com.apple.Messages", "com.apple.MigrationAssistant", "com.apple.motion",
        "com.apple.Music", "com.apple.Notes", "com.apple.Numbers",
        "com.apple.Pages", "com.apple.Photos", "com.apple.Podcasts",
        "com.apple.Preview", "com.apple.PrintCenter", "com.apple.Proxies",
        "com.apple.QuickTimePlayer", "com.apple.reminders", "com.apple.AppleSpell",
        "com.apple.Safari", "com.apple.SystemPreferences"
    ]

    static func isAppleSystemApp(bundleID: String) -> Bool {
        if blockedBundleIDs.contains(bundleID) { return true }
        return bundleID.hasPrefix("com.apple.")
    }
}
