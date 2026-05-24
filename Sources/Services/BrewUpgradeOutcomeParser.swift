import Foundation

/// Per-cask outcome extraction from `brew upgrade --cask`'s combined stdout.
///
/// brew's process exit status only tells us "all good" vs. "something
/// somewhere blew up", so a green tick on the History row would be a lie
/// for any cask that fell over inside a successful batch — and a red one
/// would be a lie for the casks that did upgrade alongside a single broken
/// sibling. The parser walks the output and pins each requested token to
/// one of three buckets:
///
/// - `.succeeded` — `🍺  <token> was successfully upgraded!` was emitted.
///   Robust against version drift because brew has shipped that exact
///   phrasing since the move to the JSON cask DSL.
/// - `.failed` — an `Error:` line appeared inside the token's section of
///   the output (between its `==> Upgrading <token>` header and the next
///   `==> Upgrading` block or end-of-output).
/// - `.attempted` — neither marker found. Default for "we don't know",
///   never for "we know it succeeded".
struct BrewUpgradeOutcomeParser {
    static func parse(stdout: String, tokens: [String]) -> [String: CaskUpgradeOutcome] {
        // Start everyone at `.attempted`; success/failure markers promote
        // out of that bucket. Unknown tokens (someone passed garbage) stay
        // `.attempted` too — never silently dropped.
        var outcomes: [String: CaskUpgradeOutcome] = [:]
        for t in tokens { outcomes[t] = .attempted }
        guard !tokens.isEmpty else { return outcomes }

        let tokenSet = Set(tokens)
        let lines = stdout.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)

        // Single-pass section walker. A token's "section" is from its
        // `==> Upgrading <token>` header to the next header or end of
        // output; success and failure markers are attributed **only** to
        // the active section. A malicious cask that prints another
        // requested token's success line inside its own section cannot
        // promote that other cask to `.succeeded` because the marker no
        // longer matches the section's token. The success line itself
        // must carry the bottle emoji that brew emits — a plain "was
        // successfully upgraded!" string is not enough.
        var currentToken: String?
        var sectionSucceeded = false
        var sectionFailed = false

        func closeSection() {
            guard let token = currentToken else { return }
            // Success wins over failure inside the same section so an
            // installer's harmless `Error: ...` warning that precedes the
            // bottle line does not flip a real success to .failed.
            if sectionSucceeded {
                outcomes[token] = .succeeded
            } else if sectionFailed {
                outcomes[token] = .failed
            }
        }

        for line in lines {
            if let next = upgradingHeaderToken(in: line) {
                closeSection()
                currentToken = tokenSet.contains(next) ? next : nil
                sectionSucceeded = false
                sectionFailed = false
                continue
            }
            guard let token = currentToken else { continue }
            if successMarkerToken(in: line) == token {
                sectionSucceeded = true
            } else if isErrorLine(line) {
                sectionFailed = true
            }
        }
        closeSection()

        return outcomes
    }

    /// Returns the cask token referenced by a `🍺  <token> was
    /// successfully upgraded!` line. Trimmed, bottle-emoji-prefixed,
    /// exact suffix match — anything else returns nil so a freeform line
    /// that happens to mention "was successfully upgraded!" cannot pose
    /// as a brew success marker.
    private static func successMarkerToken(in line: String) -> String? {
        let trimmed = line.trimmingCharacters(in: .whitespaces)
        guard trimmed.hasPrefix("🍺") else { return nil }
        let suffix = " was successfully upgraded!"
        guard trimmed.hasSuffix(suffix) else { return nil }
        let afterEmoji = trimmed.dropFirst().drop(while: { $0.isWhitespace })
        let token = afterEmoji.dropLast(suffix.count).trimmingCharacters(in: .whitespaces)
        return token.isEmpty ? nil : token
    }

    /// Returns the cask token from a line like `==> Upgrading vscode` or
    /// `==> Upgrading vscode (1.90.0) -> (1.91.0)`. Nil for any other line.
    private static func upgradingHeaderToken(in line: String) -> String? {
        let trimmed = line.trimmingCharacters(in: .whitespaces)
        let prefix = "==> Upgrading "
        guard trimmed.hasPrefix(prefix) else { return nil }
        let rest = trimmed.dropFirst(prefix.count)
        // Take the first whitespace-separated word. brew often follows the
        // token with version arrows or other annotations.
        let first = rest.split(separator: " ", maxSplits: 1).first.map(String.init) ?? ""
        let token = first.trimmingCharacters(in: .whitespaces)
        return token.isEmpty ? nil : token
    }

    private static func isErrorLine(_ line: String) -> Bool {
        let trimmed = line.trimmingCharacters(in: .whitespaces)
        return trimmed.hasPrefix("Error:") || trimmed.hasPrefix("==> Error:")
    }
}
