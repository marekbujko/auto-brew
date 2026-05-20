import XCTest
@testable import AutoBrew

final class LegalDocumentTests: XCTestCase {
    func testUniqueFilenames() {
        let filenames = LegalDocument.allCases.map(\.filename)
        XCTAssertEqual(Set(filenames).count, filenames.count)
    }

    func testTitlesPresent() {
        for doc in LegalDocument.allCases {
            XCTAssertFalse(doc.titleKey.isEmpty)
        }
    }

    func testBundleContainsEveryDocument() {
        let bundle = Bundle(for: LegalBundleAnchor.self)
        for doc in LegalDocument.allCases {
            XCTAssertNotNil(
                bundle.url(forResource: doc.filename, withExtension: "md"),
                "Missing \(doc.filename).md in test bundle"
            )
        }
    }

    func testLoadProducesContent() {
        let bundle = Bundle(for: LegalBundleAnchor.self)
        let unavailable = String(localized: "Document not available.")
        for doc in LegalDocument.allCases {
            let content = doc.load(bundle: bundle)
            XCTAssertFalse(content.isEmpty, "\(doc.filename) returned empty content")
            XCTAssertNotEqual(content, unavailable, "\(doc.filename) returned fallback string")
        }
    }

    func testFallbackStringIsLocalized() {
        XCTAssertFalse(String(localized: "Document not available.").isEmpty)
    }
}
