import Foundation
import os

extension JSONDecoder {
    static func snapshotDecoder() -> JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }
}
extension JSONEncoder {
    static func snapshotEncoder() -> JSONEncoder {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        return e
    }
}

@MainActor
final class SnapshotService {
    static let shared = SnapshotService()
    static let schemaVersion = 1

    private let storageRoot: URL
    let home: URL
    private let logger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Snapshot")
    private let fm = FileManager.default

    init(storageRoot: URL? = nil, home: URL? = nil) {
        if let storageRoot {
            self.storageRoot = storageRoot
        } else {
            let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            self.storageRoot = support.appendingPathComponent("AutoBrew/Snapshots", isDirectory: true)
        }
        self.home = home ?? FileManager.default.homeDirectoryForCurrentUser
        try? fm.createDirectory(at: self.storageRoot, withIntermediateDirectories: true)
    }

    func createSnapshot(bundleID: String, displayName: String, caskToken: String?, sourceAppVersion: String?) async throws -> AppSnapshot {
        let id = UUID()
        let timestamp = ISO8601DateFormatter().string(from: Date()).replacingOccurrences(of: ":", with: "-")
        let bundleDir = storageRoot.appendingPathComponent("\(bundleID)/\(timestamp)_\(id.uuidString.prefix(8))", isDirectory: true)
        let dataDir = bundleDir.appendingPathComponent("data", isDirectory: true)
        try fm.createDirectory(at: dataDir, withIntermediateDirectories: true)

        let resolver = SnapshotPathResolver(bundleID: bundleID, home: home)
        var components: [SnapshotComponent] = []
        var totalBytes: Int64 = 0

        for src in resolver.existingPaths() {
            let rel = src.path.replacingOccurrences(of: home.path + "/", with: "")
            let dest = dataDir.appendingPathComponent(rel)
            try fm.createDirectory(at: dest.deletingLastPathComponent(), withIntermediateDirectories: true)

            var isDir: ObjCBool = false
            fm.fileExists(atPath: src.path, isDirectory: &isDir)
            if isDir.boolValue {
                try fm.copyItem(at: src, to: dest)
                let size = try directorySize(at: dest)
                totalBytes += size
                components.append(SnapshotComponent(
                    originalPath: src.path.replacingOccurrences(of: home.path, with: "~"),
                    relativeArchivePath: rel,
                    kind: .directory,
                    sha256: nil,
                    byteSize: size
                ))
            } else {
                try fm.copyItem(at: src, to: dest)
                let attrs = try fm.attributesOfItem(atPath: dest.path)
                let size = (attrs[.size] as? Int64) ?? 0
                let hash = try Sha256Hasher.hash(file: dest)
                totalBytes += size
                components.append(SnapshotComponent(
                    originalPath: src.path.replacingOccurrences(of: home.path, with: "~"),
                    relativeArchivePath: rel,
                    kind: .file,
                    sha256: hash,
                    byteSize: size
                ))
            }
        }

        let manifest = SnapshotManifest(
            id: id,
            bundleID: bundleID,
            displayName: displayName,
            caskToken: caskToken,
            sourceAppVersion: sourceAppVersion,
            createdAt: Date(),
            originHost: Host.current().localizedName ?? "Unknown",
            originUser: NSUserName(),
            schemaVersion: Self.schemaVersion,
            components: components
        )
        let manifestData = try JSONEncoder.snapshotEncoder().encode(manifest)
        try manifestData.write(to: bundleDir.appendingPathComponent("manifest.json"))

        logger.info("Created snapshot \(bundleID, privacy: .public) with \(components.count) components (\(totalBytes) bytes)")

        return AppSnapshot(
            id: id, bundleID: bundleID, displayName: displayName,
            createdAt: manifest.createdAt, caskToken: caskToken,
            sourceAppVersion: sourceAppVersion, totalBytes: totalBytes,
            bundleURL: bundleDir
        )
    }

    func listSnapshots() throws -> [AppSnapshot] {
        guard fm.fileExists(atPath: storageRoot.path) else { return [] }
        var result: [AppSnapshot] = []
        let bundleDirs = try fm.contentsOfDirectory(at: storageRoot, includingPropertiesForKeys: nil)
        for bundleDir in bundleDirs {
            let timestampDirs = (try? fm.contentsOfDirectory(at: bundleDir, includingPropertiesForKeys: nil)) ?? []
            for tsDir in timestampDirs {
                let manifestURL = tsDir.appendingPathComponent("manifest.json")
                guard fm.fileExists(atPath: manifestURL.path) else { continue }
                guard let data = try? Data(contentsOf: manifestURL),
                      let manifest = try? JSONDecoder.snapshotDecoder().decode(SnapshotManifest.self, from: data) else { continue }
                let total = manifest.components.reduce(Int64(0)) { $0 + $1.byteSize }
                result.append(AppSnapshot(
                    id: manifest.id,
                    bundleID: manifest.bundleID,
                    displayName: manifest.displayName,
                    createdAt: manifest.createdAt,
                    caskToken: manifest.caskToken,
                    sourceAppVersion: manifest.sourceAppVersion,
                    totalBytes: total,
                    bundleURL: tsDir
                ))
            }
        }
        return result.sorted { $0.createdAt > $1.createdAt }
    }

    func deleteSnapshot(_ snapshot: AppSnapshot) throws {
        try fm.removeItem(at: snapshot.bundleURL)
        let parent = snapshot.bundleURL.deletingLastPathComponent()
        if let remaining = try? fm.contentsOfDirectory(at: parent, includingPropertiesForKeys: nil), remaining.isEmpty {
            try? fm.removeItem(at: parent)
        }
    }

    private func directorySize(at url: URL) throws -> Int64 {
        var total: Int64 = 0
        guard let enumerator = fm.enumerator(at: url, includingPropertiesForKeys: [.fileSizeKey]) else { return 0 }
        for case let item as URL in enumerator {
            let attrs = try item.resourceValues(forKeys: [.fileSizeKey])
            total += Int64(attrs.fileSize ?? 0)
        }
        return total
    }
}
