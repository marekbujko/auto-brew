import Foundation
import os

private let collectionsLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Collections")

/// File-backed CRUD store for cask collections. Lives next to the
/// other AutoBrew JSON state under
/// `~/Library/Application Support/AutoBrew/Collections.json`.
@Observable
@MainActor
final class CollectionsStore {
    static let shared = CollectionsStore()

    private(set) var collections: [CaskCollection] = []
    private let fileURL: URL

    init(fileURL: URL? = nil) {
        if let fileURL {
            self.fileURL = fileURL
        } else {
            let base = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .first!
                .appendingPathComponent("AutoBrew", isDirectory: true)
            try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
            self.fileURL = base.appendingPathComponent("Collections.json")
        }
        load()
    }

    /// Newest-updated first so the user sees what they touched last.
    var sortedCollections: [CaskCollection] {
        collections.sorted { $0.updatedAt > $1.updatedAt }
    }

    func create(name: String, tokens: [String] = []) -> CaskCollection {
        let collection = CaskCollection(name: name, tokens: tokens)
        collections.append(collection)
        save()
        return collection
    }

    func rename(_ id: CaskCollection.ID, to newName: String) {
        update(id) { $0.name = newName }
    }

    func setTokens(_ id: CaskCollection.ID, to tokens: [String]) {
        update(id) { $0.tokens = tokens.sorted() }
    }

    func addToken(_ token: String, to id: CaskCollection.ID) {
        update(id) { collection in
            guard !collection.tokens.contains(token) else { return }
            collection.tokens = (collection.tokens + [token]).sorted()
        }
    }

    func removeToken(_ token: String, from id: CaskCollection.ID) {
        update(id) { $0.tokens.removeAll { $0 == token } }
    }

    func delete(_ id: CaskCollection.ID) {
        collections.removeAll { $0.id == id }
        save()
    }

    /// Imports a collection from a `.autobrewcollection` file. Newer
    /// imports get a fresh UUID so they don't clobber an existing
    /// collection with the same id.
    func `import`(from url: URL) throws -> CaskCollection {
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder.iso8601.decode(CaskCollection.self, from: data)
        let imported = CaskCollection(
            id: UUID(),
            name: decoded.name,
            tokens: decoded.tokens,
            createdAt: Date(),
            updatedAt: Date()
        )
        collections.append(imported)
        save()
        return imported
    }

    func export(_ id: CaskCollection.ID, to url: URL) throws {
        guard let collection = collections.first(where: { $0.id == id }) else {
            throw CocoaError(.fileNoSuchFile)
        }
        let data = try JSONEncoder.iso8601.encode(collection)
        try data.write(to: url, options: .atomic)
    }

    // MARK: - Persistence

    private func update(_ id: CaskCollection.ID, mutate: (inout CaskCollection) -> Void) {
        guard let index = collections.firstIndex(where: { $0.id == id }) else { return }
        mutate(&collections[index])
        collections[index].updatedAt = Date()
        save()
    }

    private func load() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            collections = try JSONDecoder.iso8601.decode([CaskCollection].self, from: data)
        } catch {
            collectionsLogger.error("Failed to read collections, starting fresh: \(error.localizedDescription, privacy: .public)")
            collections = []
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder.iso8601.encode(collections)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            collectionsLogger.error("Failed to write collections: \(error.localizedDescription, privacy: .public)")
        }
    }
}
