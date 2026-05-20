import Foundation
import CryptoKit

/// Streaming SHA-256 over a file. We read in 64 KB chunks inside an
/// `autoreleasepool` because `FileHandle.readData` returns autoreleased `Data`
/// — without the pool a multi-gigabyte snapshot would balloon resident memory
/// until the call returns.
enum Sha256Hasher {
    static func hash(file url: URL) throws -> String {
        let handle = try FileHandle(forReadingFrom: url)
        defer { try? handle.close() }

        var hasher = SHA256()
        let chunkSize = 64 * 1024
        while autoreleasepool(invoking: { () -> Bool in
            let chunk = handle.readData(ofLength: chunkSize)
            if chunk.isEmpty { return false }
            hasher.update(data: chunk)
            return true
        }) {}
        return hasher.finalize().map { String(format: "%02x", $0) }.joined()
    }
}
