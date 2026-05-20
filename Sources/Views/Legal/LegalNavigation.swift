import Foundation
import Observation

@Observable
@MainActor
final class LegalNavigation {
    static let shared = LegalNavigation()
    var requestedDocument: LegalDocument = .privacy

    private init() {}
}
