import Foundation

/// A named set of cask tokens the user installs as a unit — "Dev
/// Setup", "Gaming Setup", "New Laptop". Persisted in
/// `~/Library/Application Support/AutoBrew/Collections.json` and
/// exportable as `.autobrewcollection` JSON for cross-Mac sharing.
struct CaskCollection: Codable, Sendable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var tokens: [String]
    let createdAt: Date
    var updatedAt: Date

    init(id: UUID = UUID(),
         name: String,
         tokens: [String] = [],
         createdAt: Date = Date(),
         updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        // Stable sort so two collections with the same token set hash
        // to the same fingerprint regardless of insertion order — keeps
        // diffs noise-free.
        self.tokens = tokens.sorted()
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
