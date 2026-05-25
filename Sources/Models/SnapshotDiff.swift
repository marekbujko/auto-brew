import Foundation

/// Pair-wise diff between two snapshots of the same bundle. Built by
/// `SnapshotService.diff(_:_:)` from the manifest components alone —
/// no extra hashing on the live filesystem.
///
/// Components are matched by `relativeArchivePath`, so the diff is
/// stable across snapshots created at different times on different
/// machines as long as the resolver picks the same paths.
struct SnapshotDiff: Sendable, Equatable {
    /// Components that exist only in the **right** (newer) snapshot.
    let added: [SnapshotComponent]

    /// Components that exist only in the **left** (older) snapshot.
    let removed: [SnapshotComponent]

    /// Components that exist in both snapshots but whose SHA-256
    /// differs (for files) or whose directory tree hash differs (for
    /// folders). The pair carries the older/newer entries so the UI
    /// can render both sizes side by side.
    let changed: [Pair]

    /// Components present in both snapshots with identical hashes —
    /// kept in the diff so the UI can render an honest "X
    /// unchanged" footer instead of pretending nothing matched.
    let unchanged: [Pair]

    struct Pair: Sendable, Equatable {
        let oldComponent: SnapshotComponent
        let newComponent: SnapshotComponent

        /// Positive when the newer component grew, negative when it
        /// shrank. Suitable for a `+Δ` / `−Δ` size label in the UI.
        var byteDelta: Int64 {
            newComponent.byteSize - oldComponent.byteSize
        }
    }

    var totalAddedBytes: Int64 {
        added.reduce(into: Int64(0)) { $0 += max(0, $1.byteSize) }
    }

    var totalRemovedBytes: Int64 {
        removed.reduce(into: Int64(0)) { $0 += max(0, $1.byteSize) }
    }

    var totalChangedBytesDelta: Int64 {
        changed.reduce(into: Int64(0)) { $0 += $1.byteDelta }
    }
}
