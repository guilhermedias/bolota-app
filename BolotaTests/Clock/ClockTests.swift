import XCTest

@testable import Bolota

class ClockTests: XCTestCase {

    var clock: Clock = Clock(1280)

    func testMinutesCount() {
        XCTAssert(clock.getMinutesCount() == 2)
    }

    func testTimeString() {
        XCTAssert(clock.timeString() == "00:02:08")
    }

    func testClockRunning() {
        XCTAssert(clock.isRunning() == false)

        clock.start {}

        XCTAssert(clock.isRunning() == true)

        clock.stop()

        XCTAssert(clock.isRunning() == false)
    }
}
