import XCTest
@testable import AutoBrew

final class DoctorReportTests: XCTestCase {
    func testHealthyOutputProducesEmptyFindings() {
        let raw = "Your system is ready to brew."
        let report = DoctorReport.parse(raw)
        XCTAssertTrue(report.isHealthy)
        XCTAssertEqual(report.findings.count, 0)
    }

    func testSingleWarningBlockParses() {
        let raw = """
        Warning: Some installed formulae are missing dependencies.
          You should run `brew missing` to see which ones.
        """
        let report = DoctorReport.parse(raw)
        XCTAssertEqual(report.findings.count, 1)
        XCTAssertEqual(report.findings.first?.severity, .warning)
        XCTAssertEqual(report.findings.first?.title, "Some installed formulae are missing dependencies.")
        XCTAssertEqual(report.findings.first?.body.contains("brew missing"), true)
    }

    func testErrorBlockClassifiedAsError() {
        let raw = """
        Error: Something blew up.
          Detail line one.
        """
        let report = DoctorReport.parse(raw)
        XCTAssertEqual(report.errorCount, 1)
        XCTAssertEqual(report.warningCount, 0)
        XCTAssertEqual(report.findings.first?.severity, .error)
    }

    func testMultipleBlocksSplitOnBlankLine() {
        let raw = """
        Warning: One thing.
          More about one.

        Warning: Second thing.
          More about two.

        Error: Third thing went wrong.
          Real bad.
        """
        let report = DoctorReport.parse(raw)
        XCTAssertEqual(report.warningCount, 2)
        XCTAssertEqual(report.errorCount, 1)
        XCTAssertEqual(report.findings.count, 3)
    }

    func testUnclassifiedBlocksAreIgnored() {
        let raw = """
        Some uncategorized chatter brew sometimes emits.

        Warning: Real warning.
          Detail.

        Another stray header without a Warning:/Error: prefix.
        """
        let report = DoctorReport.parse(raw)
        XCTAssertEqual(report.findings.count, 1,
                       "Only the Warning: block should land in findings")
        XCTAssertEqual(report.findings.first?.title, "Real warning.")
    }
}
