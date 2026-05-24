import XCTest
@testable import AutoBrew

final class DiskSpaceMonitorTests: XCTestCase {
    /// Smoke test against the real home directory volume — should
    /// always answer with something on a developer machine, never
    /// negative.
    func testAvailableBytesReturnsPositiveOnDevMachine() {
        let bytes = DiskSpaceMonitor.availableBytes()
        XCTAssertNotNil(bytes, "Home directory volume should report capacity on a real Mac")
        if let bytes {
            XCTAssertGreaterThan(bytes, 0, "Capacity must be positive")
        }
    }

    /// The threshold helper rounds GiB → bytes correctly and answers
    /// `true` for a tiny threshold that any working dev machine
    /// exceeds.
    func testHasAtLeastTrueForLowThreshold() {
        XCTAssertTrue(DiskSpaceMonitor.hasAtLeast(1),
                      "Any working machine has at least 1 GiB free")
    }

    /// A wildly oversized threshold returns false unless the API
    /// returns nil — then the helper defaults to "skip the check" so
    /// the feature does not silently disable itself.
    func testHasAtLeastFalseForOverThreshold() {
        if DiskSpaceMonitor.availableBytes() != nil {
            XCTAssertFalse(DiskSpaceMonitor.hasAtLeast(1_000_000),
                           "Petabytes of free space are not realistic on a dev machine")
        }
    }
}
