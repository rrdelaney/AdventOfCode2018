import XCTest
@testable import Day06Lib

final class Day06Tests: XCTestCase {
    func testPart1Case1() {
      let coords = [
        "1, 1",
        "1, 6",
        "8, 3",
        "3, 4",
        "5, 5",
        "8, 9",
      ]

      let largestArea = Day06Lib.getLargestArea(coords: coords)
      XCTAssertEqual(largestArea, 17)
    }

    func testPart2Case1() {
      let coords = [
        "1, 1",
        "1, 6",
        "8, 3",
        "3, 4",
        "5, 5",
        "8, 9",
      ]

      let safeArea = Day06Lib.getSafeArea(coords: coords, maxDistance: 32)
      XCTAssertEqual(safeArea, 16)
    }

    static var allTests = [
        ("testPart1Case1", testPart1Case1),
        ("testPart2Case1", testPart2Case1),
    ]
}
