import Foundation
import os

private let ledgerLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "UpdateLedger")

/// Tracks when AutoBrew first noticed a given `(token, availableVersion)`
/// combination. Needed so `UpdatePolicy.delayedDays` can measure the
/// "cool-off" window from the first sighting, not from each subsequent scan.
///
/// Persisted as JSON in Application Support — small enough to read/write
/// synchronously on the scheduler thread.
struct UpdateLedger: Sendable, Equatable {
    /// One row per `(token, version)`. The composite key lets us reset the
    /// timer when a newer version shows up.
    struct Entry: Codable, Sendable, Equatable {
        let token: String
        let version: String
        let firstSeen: Date
    }

    private(set) var entries: [String: Entry] = [:]

    init(entries: [String: Entry] = [:]) {
        self.entries = entries
    }

    /// Returns the existing `firstSeen` or inserts `now` if this is the first
    /// time we see this specific `(token, version)`. Updating the version
    /// resets the timer.
    mutating func touch(token: String, version: String, now: Date) -> Date {
        let key = Self.key(token: token, version: version)
        if let existing = entries[key] {
            return existing.firstSeen
        }
        // A different version exists for this token → drop the old entry.
        entries = entries.filter { $0.value.token != token }
        let entry = Entry(token: token, version: version, firstSeen: now)
        entries[key] = entry
        return now
    }

    /// Drops entries whose `(token, version)` is no longer outdated. Called
    /// after each run so the file doesn't grow forever.
    mutating func purge(keeping activeKeys: Set<String>) {
        entries = entries.filter { activeKeys.contains($0.key) }
    }

    /// Composite key — used for both the in-memory map and tests that need
    /// to peek at the file format.
    static func key(token: String, version: String) -> String {
        "\(token)::\(version)"
    }
}

extension UpdateLedger: Codable {
    enum CodingKeys: String, CodingKey { case entries }
}

/// File-backed wrapper around `UpdateLedger`. Lives next to the snapshot
/// storage in Application Support.
@MainActor
final class UpdateLedgerStore {
    private let fileURL: URL
    private(set) var ledger: UpdateLedger

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
            url = base.appendingPathComponent("UpdateLedger.json")
        }
        self.fileURL = url
        self.ledger = Self.load(from: url)
    }

    func save() {
        do {
            let data = try JSONEncoder.iso8601.encode(ledger)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            ledgerLogger.error("Failed to write update ledger: \(error.localizedDescription, privacy: .public)")
        }
    }

    func touch(token: String, version: String, now: Date = Date()) -> Date {
        let result = ledger.touch(token: token, version: version, now: now)
        save()
        return result
    }

    func purge(keeping activeKeys: Set<String>) {
        ledger.purge(keeping: activeKeys)
        save()
    }

    private static func load(from url: URL) -> UpdateLedger {
        guard FileManager.default.fileExists(atPath: url.path) else {
            return UpdateLedger()
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder.iso8601.decode(UpdateLedger.self, from: data)
        } catch {
            ledgerLogger.error("Failed to read update ledger, starting fresh: \(error.localizedDescription, privacy: .public)")
            return UpdateLedger()
        }
    }
}

extension JSONEncoder {
    static let iso8601: JSONEncoder = {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        return e
    }()
}

extension JSONDecoder {
    static let iso8601: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()
}
