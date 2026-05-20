import SwiftUI

/// Block-level Markdown renderer built on top of `AttributedString` for inline
/// styling. Hand-rolled rather than pulled from SPM because the legal texts
/// only use a handful of constructs and we don't want a third-party dependency
/// for something this small.
struct MarkdownView: View {
    let blocks: [MarkdownBlock]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(blocks.enumerated()), id: \.offset) { _, block in
                render(block)
            }
        }
    }

    @ViewBuilder
    private func render(_ block: MarkdownBlock) -> some View {
        switch block {
        case .heading1(let text):
            Text(inline(text))
                .font(.title.bold())
                .padding(.top, 8)
        case .heading2(let text):
            Text(inline(text))
                .font(.title2.bold())
                .padding(.top, 6)
        case .heading3(let text):
            Text(inline(text))
                .font(.headline)
                .padding(.top, 4)
        case .paragraph(let text):
            Text(inline(text))
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        case .bulletList(let items):
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                            .font(.body)
                            .foregroundStyle(.secondary)
                        Text(inline(item))
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .numberedList(let items):
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(alignment: .top, spacing: 8) {
                        Text("\(index + 1).")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .frame(minWidth: 20, alignment: .trailing)
                        Text(inline(item))
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .horizontalRule:
            Divider()
                .padding(.vertical, 4)
        }
    }

    /// Inline parser handles `**bold**`, `*italic*`, `` `code` ``, `[link](url)`.
    /// Block-level constructs are pre-stripped by `MarkdownParser`; if Apple's
    /// parser still fails we render the raw text rather than dropping it.
    private func inline(_ text: String) -> AttributedString {
        (try? AttributedString(markdown: text, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
            ?? AttributedString(text)
    }
}

enum MarkdownBlock: Equatable, Sendable {
    case heading1(String)
    case heading2(String)
    case heading3(String)
    case paragraph(String)
    case bulletList([String])
    case numberedList([String])
    case horizontalRule
}

enum MarkdownParser {
    /// Line-oriented parser. Greedy: collects consecutive paragraph / list
    /// lines into buffers and flushes them on blank lines, headings, or rules.
    static func parse(_ text: String) -> [MarkdownBlock] {
        // Some editors save legal docs with CRLF; strip the carriage return
        // up front so heading / bullet detection still works.
        let normalized = text.replacingOccurrences(of: "\r\n", with: "\n")

        var blocks: [MarkdownBlock] = []
        var paragraphBuffer: [String] = []
        var bulletBuffer: [String] = []
        var numberedBuffer: [String] = []

        func flushParagraph() {
            guard !paragraphBuffer.isEmpty else { return }
            blocks.append(.paragraph(paragraphBuffer.joined(separator: " ")))
            paragraphBuffer.removeAll()
        }

        func flushBullets() {
            guard !bulletBuffer.isEmpty else { return }
            blocks.append(.bulletList(bulletBuffer))
            bulletBuffer.removeAll()
        }

        func flushNumbered() {
            guard !numberedBuffer.isEmpty else { return }
            blocks.append(.numberedList(numberedBuffer))
            numberedBuffer.removeAll()
        }

        func flushAll() {
            flushParagraph()
            flushBullets()
            flushNumbered()
        }

        for rawLine in normalized.components(separatedBy: "\n") {
            let line = rawLine.trimmingCharacters(in: .whitespacesAndNewlines)

            if line.isEmpty {
                flushAll()
                continue
            }

            if line == "---" || line == "***" {
                flushAll()
                blocks.append(.horizontalRule)
                continue
            }

            if line.hasPrefix("### ") {
                flushAll()
                blocks.append(.heading3(String(line.dropFirst(4))))
                continue
            }
            if line.hasPrefix("## ") {
                flushAll()
                blocks.append(.heading2(String(line.dropFirst(3))))
                continue
            }
            if line.hasPrefix("# ") {
                flushAll()
                blocks.append(.heading1(String(line.dropFirst(2))))
                continue
            }

            if line.hasPrefix("- ") || line.hasPrefix("* ") {
                flushParagraph()
                flushNumbered()
                bulletBuffer.append(String(line.dropFirst(2)))
                continue
            }

            if let numberedItem = parseNumberedItem(line) {
                flushParagraph()
                flushBullets()
                numberedBuffer.append(numberedItem)
                continue
            }

            // Paragraph line — soft-wrap by appending to the current buffer.
            flushBullets()
            flushNumbered()
            paragraphBuffer.append(line)
        }

        flushAll()
        return blocks
    }

    /// Recognises `1. text`, `42. text`, etc. Returns the trimmed text after
    /// the period; returns `nil` if the line does not look like a numbered item.
    private static func parseNumberedItem(_ line: String) -> String? {
        var index = line.startIndex
        while index < line.endIndex, line[index].isNumber {
            index = line.index(after: index)
        }
        guard index > line.startIndex,
              index < line.endIndex,
              line[index] == ".",
              line.index(after: index) < line.endIndex,
              line[line.index(after: index)] == " " else {
            return nil
        }
        return String(line[line.index(index, offsetBy: 2)...])
    }
}
