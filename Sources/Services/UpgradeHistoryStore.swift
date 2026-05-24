import Foundation
import os

private let upgradeHistoryLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "UpgradeHistory")

/// File-backed history of every auto-upgrade AutoBrew ran. Newest first.
/// Lives next to UpdateLedger.json in Application Support; small enough to
/// read/write synchronously on the scheduler thread.
@Observable
@MainActor
final class UpgradeHistoryStore {
    static let shared = UpgradeHistoryStore()

    private let fileURL: URL
    private(set) var entries: [UpgradeHistoryEntry] = []

    init(fileURL: URL? = nil) {
        let url: URL
        if let fileURL {
            url = fileURL
        } else {
            let base = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first!
                .appendingPathComponent("AutoBrew", isDirectory: true)
            try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
            url = base.appendingPathComponent("UpgradeHistory.json")
        }
        self.fileURL = url
        self.entries = Self.load(from: url)
    }

    func append(_ entry: UpgradeHistoryEntry) {
        // Newest first so the view doesn't have to re-sort on every render.
        entries.insert(entry, at: 0)
        save()
    }

    /// Trim the history beyond `days`. Called from the same housekeeping pass
    /// that runs the snapshot retention so a snapshot-less history row never
    /// outlives the retention window the user opted into.
    func prune(olderThanDays days: Int) {
        guard days > 0 else { return }
        let cutoff = Date().addingTimeInterval(-Double(days) * 86_400)
        let before = entries.count
        entries.removeAll { $0.timestamp < cutoff }
        if entries.count != before { save() }
    }

    private func save() {
        do {
            let data = try JSONEncoder.iso8601.encode(entries)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            upgradeHistoryLogger.error("Failed to write upgrade history: \(error.localizedDescription, privacy: .public)")
        }
    }

    private static func load(from url: URL) -> [UpgradeHistoryEntry] {
        guard FileManager.default.fileExists(atPath: url.path) else { return [] }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder.iso8601.decode([UpgradeHistoryEntry].self, from: data)
        } catch {
            upgradeHistoryLogger.error("Failed to read upgrade history, starting fresh: \(error.localizedDescription, privacy: .public)")
            return []
        }
    }
}
