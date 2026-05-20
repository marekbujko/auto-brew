import Foundation
import Observation

/// Cross-scene state for the BrewStore window. AppDelegate (URL handlers,
/// notification actions) sets `requestedSection` then posts
/// `.openBrewStoreWindow`; the window reads this on appear to deep-link into
/// the right tab.
///
/// Singleton for the same reason `LegalNavigation` is one — `openWindow`
/// doesn't carry a payload on macOS.
@Observable
@MainActor
final class BrewStoreNavigation {
    static let shared = BrewStoreNavigation()
    var requestedSection: BrewStoreSection?

    private init() {}
}
