import Foundation
import Observation

/// Cross-scene state for the Legal window. Callers (Settings, About sheet,
/// onboarding links, autobrew:// URLs) set `requestedDocument` and then post
/// `.openLegalWindow` — the SwiftUI `Window` scene reads this on appear so
/// the right tab is preselected.
///
/// A singleton because `@Environment(\.openWindow)` lives inside a `View`
/// and there's no clean way to pass document selection through `openWindow`
/// itself on macOS.
@Observable
@MainActor
final class LegalNavigation {
    static let shared = LegalNavigation()
    var requestedDocument: LegalDocument = .privacy

    private init() {}
}
