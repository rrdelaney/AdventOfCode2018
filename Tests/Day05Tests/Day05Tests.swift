import XCTest
@testable import Day05Lib

final class Day05Tests: XCTestCase {
    func testPart1Case1() {
      let polymer = "dabAcCaCBAcCcaDA"
      let count = Day05Lib.collapseAndCount(polymer: polymer)
      XCTAssertEqual(count, 10)
    }

    func testPart2Case1() {
      let polymer = "dabAcCaCBAcCcaDA"
      let count = Day05Lib.optimizedCollapseAndCount(polymer: polymer)
      XCTAssertEqual(count, 4)
    }

    static var allTests = [
        ("testPart1Case1", testPart1Case1),
        ("testPart2Case1", testPart2Case1),
    ]
}
