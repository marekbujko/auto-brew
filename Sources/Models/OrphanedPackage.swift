import Foundation

/// A formula that `brew autoremove --dry-run` reported as
/// "no-longer-needed" — a dependency of something the user
/// explicitly installed that is now orphaned because the parent was
/// uninstalled (or the dependency was lifted upstream). Removing
/// orphans is safe by definition; the user just gets disk space back.
struct OrphanedPackage: Identifiable, Sendable, Equatable {
    let name: String
    var id: String { name }
}
