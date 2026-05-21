import SwiftUI

/// Standalone window that shows the legal documents. Deep-link entry points
/// (Settings buttons, About sheet, future onboarding) set
/// `LegalNavigation.shared.requestedDocument` and post `.openLegalWindow`;
/// this view picks up the change through the observed singleton.
@MainActor
struct LegalView: View {
    @State private var navigation = LegalNavigation.shared
    // Parsed markdown is cached per document so switching tabs doesn't
    // re-parse from disk. The cache lives as long as the window does.
    @State private var blocksCache: [LegalDocument: [MarkdownBlock]] = [:]

    var body: some View {
        let selection = Binding(
            get: { navigation.requestedDocument },
            set: { navigation.requestedDocument = $0 }
        )

        VStack(spacing: 0) {
            // VoiceOver needs the real label even though we hide it visually,
            // otherwise the segmented picker is announced as "Picker" with no
            // context about what's being selected.
            Picker("Legal document", selection: selection) {
                ForEach(LegalDocument.allCases) { doc in
                    Text(LocalizedStringKey(doc.titleKey)).tag(doc)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .accessibilityLabel(Text("Legal document"))
            .padding(.horizontal, 20)
            .padding(.vertical, 12)

            Divider()

            // `.id(...)` on the ScrollView forces SwiftUI to rebuild the
            // scrollable container when the selected document changes, which
            // resets the scroll offset to the top — otherwise switching from
            // a long Privacy Policy to a short EULA would leave the user
            // scrolled into empty space at the bottom.
            ScrollView {
                MarkdownView(blocks: blocksCache[navigation.requestedDocument] ?? [])
                    .padding(24)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .id(navigation.requestedDocument)
        }
        .frame(minWidth: 640, idealWidth: 760, minHeight: 480, idealHeight: 640)
        .navigationTitle("Legal")
        .task(id: navigation.requestedDocument) {
            let doc = navigation.requestedDocument
            guard blocksCache[doc] == nil else { return }
            blocksCache[doc] = MarkdownParser.parse(doc.load())
        }
    }
}
