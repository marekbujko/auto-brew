import SwiftUI

struct LegalView: View {
    @State private var navigation = LegalNavigation.shared
    @State private var selectedDocument: LegalDocument = LegalNavigation.shared.requestedDocument

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $selectedDocument) {
                ForEach(LegalDocument.allCases) { doc in
                    Text(LocalizedStringKey(doc.titleKey)).tag(doc)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .padding(.horizontal, 20)
            .padding(.vertical, 12)

            Divider()

            ScrollView {
                MarkdownView(content: selectedDocument.load())
                    .padding(24)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .id(selectedDocument)
            }
        }
        .frame(minWidth: 640, idealWidth: 760, minHeight: 480, idealHeight: 640)
        .navigationTitle("Legal")
        .onAppear {
            selectedDocument = navigation.requestedDocument
        }
        .onChange(of: navigation.requestedDocument) { _, newValue in
            selectedDocument = newValue
        }
    }
}
