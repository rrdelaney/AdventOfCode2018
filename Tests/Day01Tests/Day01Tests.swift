@testable import Day01Lib
import XCTest

final class Day01Tests: XCTestCase {
    func testPart1Case1() {
      let freqs = [+1, +1, +1]
      let drift = Day01Lib.findFreqDrift(freqs: freqs)
      XCTAssertEqual(drift, 3)
    }

    func testPart1Case2() {
      let freqs = [+1, +1, -2]
      let drift = Day01Lib.findFreqDrift(freqs: freqs)
      XCTAssertEqual(drift, 0)
    }

    func testPart1Case3() {
      let freqs = [-1, -2, -3]
      let drift = Day01Lib.findFreqDrift(freqs: freqs)
      XCTAssertEqual(drift, -6)
    }

    func testPart2Case1() {
      let freqs = [+1, -1]
      let firstRecurringFreq = Day01Lib.findFirstRecurringFreq(freqs: freqs)
      XCTAssertEqual(firstRecurringFreq, 0)
    }

    func testPart2Case2() {
      let freqs = [+3, +3, +4, -2, -4]
      let firstRecurringFreq = Day01Lib.findFirstRecurringFreq(freqs: freqs)
      XCTAssertEqual(firstRecurringFreq, 10)
    }

    func testPart2Case3() {
      let freqs = [-6, +3, +8, +5, -6]
      let firstRecurringFreq = Day01Lib.findFirstRecurringFreq(freqs: freqs)
      XCTAssertEqual(firstRecurringFreq, 5)
    }

    func testPart2Case4() {
      let freqs = [+7, +7, -2, -7, -4]
      let firstRecurringFreq = Day01Lib.findFirstRecurringFreq(freqs: freqs)
      XCTAssertEqual(firstRecurringFreq, 14)
    }


    static var allTests = [
        ("testPart1Case1", testPart1Case1),
        ("testPart1Case2", testPart1Case2),
        ("testPart1Case3", testPart1Case3),
        ("testPart2Case1", testPart2Case1),
        ("testPart2Case2", testPart2Case2),
        ("testPart2Case3", testPart2Case3),
        ("testPart2Case4", testPart2Case4),
    ]
}
