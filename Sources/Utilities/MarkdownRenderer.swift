import Foundation

/// Tiny wrapper around `AttributedString(markdown:)` so view code can
/// stay declarative without sprinkling `try?` everywhere. Fails open
/// to a plain-text `AttributedString` so a malformed release-notes
/// body never crashes the pending-approvals row.
enum MarkdownRenderer {
    static func render(_ markdown: String) -> AttributedString {
        if let attributed = try? AttributedString(
            markdown: markdown,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return attributed
        }
        return AttributedString(markdown)
    }
}
