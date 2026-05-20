import Foundation
import os

private let legalLogger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Legal")

/// Reference type whose `Bundle(for:)` lookup returns the AutoBrew app bundle,
/// so tests can find the localized `.md` resources without depending on `.main`.
final class LegalBundleAnchor {}

enum LegalDocument: String, CaseIterable, Identifiable, Sendable {
    case privacy
    case terms
    case eula
    case impressum
    case trademark
    case openSource

    var id: String { rawValue }

    var titleKey: String {
        switch self {
        case .privacy: return "Privacy Policy"
        case .terms: return "Terms of Use"
        case .eula: return "EULA"
        case .impressum: return "Imprint"
        case .trademark: return "Trademark"
        case .openSource: return "Open-Source Licenses"
        }
    }

    var filename: String {
        switch self {
        case .privacy: return "PrivacyPolicy"
        case .terms: return "TermsOfUse"
        case .eula: return "EULA"
        case .impressum: return "Impressum"
        case .trademark: return "Trademark"
        case .openSource: return "OpenSourceLicenses"
        }
    }

    func load(bundle: Bundle = .main) -> String {
        guard let url = bundle.url(forResource: filename, withExtension: "md") else {
            legalLogger.error("LegalDocument: \(self.filename, privacy: .public).md not found in bundle")
            return String(localized: "Document not available.")
        }
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            legalLogger.error("LegalDocument: failed to read \(self.filename, privacy: .public).md: \(error.localizedDescription, privacy: .public)")
            return String(localized: "Document not available.")
        }
    }
}
