import Foundation

/// A single entry from `formulae.brew.sh/api/cask.json`. We only decode the
/// fields we actually render; the upstream payload is much larger (uninstall
/// stanzas, zap targets, sha256s, depends_on, …) and changes frequently, so we
/// stay deliberately narrow and tolerate missing keys with `try?` fallbacks.
///
/// `appNames` is flattened out of the nested `artifacts` array because that's
/// the only place Homebrew records the `.app` bundles a cask installs.
struct CaskCatalogEntry: Decodable, Identifiable, Sendable, Hashable {
    let token: String
    let nameValues: [String]
    let description: String?
    let homepage: String
    let url: String
    let version: String
    let appNames: [String]

    var id: String { token }
    /// Raw upstream name (without the variant suffix). Use this when matching
    /// against installed apps or looking up artwork.
    var displayName: String { nameValues.first ?? token }

    /// Name shown in the BrewStore lists. Casks that pin a specific major
    /// version (`alfred@4`) or ship a non-stable channel (`alfred@prerelease`)
    /// share their `displayName` with the default cask, which is confusing.
    /// Surface the variant straight from the token: `Alfred 4`,
    /// `Alfred (Prerelease)`, `Docker (Beta)`, …
    var presentationName: String {
        guard let separator = token.range(of: "@") else { return displayName }
        let suffix = token[separator.upperBound...]
        guard !suffix.isEmpty else { return displayName }

        if let major = Int(suffix) {
            return "\(displayName) \(major)"
        }
        // Channel-style suffixes like `prerelease`, `beta`, `nightly`, `dev`.
        let pretty = suffix.prefix(1).uppercased() + suffix.dropFirst()
        return "\(displayName) (\(pretty))"
    }

    enum CodingKeys: String, CodingKey {
        case token, name, desc, homepage, url, version, artifacts
    }

    private struct Artifact: Decodable {
        let app: [String]?
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        token = try c.decode(String.self, forKey: .token)
        nameValues = (try? c.decode([String].self, forKey: .name)) ?? []
        description = try c.decodeIfPresent(String.self, forKey: .desc)
        homepage = (try? c.decode(String.self, forKey: .homepage)) ?? ""
        url = (try? c.decode(String.self, forKey: .url)) ?? ""
        version = (try? c.decode(String.self, forKey: .version)) ?? ""
        let artifacts = (try? c.decode([Artifact].self, forKey: .artifacts)) ?? []
        appNames = artifacts.flatMap { $0.app ?? [] }
    }
}
