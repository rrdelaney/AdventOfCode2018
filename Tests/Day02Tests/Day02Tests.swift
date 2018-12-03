import XCTest
@testable import Day02Lib

final class Day02Tests: XCTestCase {
    func testPart1Case1() {
      let ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
      let checksum = Day02Lib.calculateChecksum(ids: ids)
      XCTAssertEqual(checksum, 12)
    }

    func testPart2Case1() {
      let ids = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
      let closestChars = Day02Lib.findClosest(ids: ids)
      XCTAssertEqual(closestChars, "fgij")
    }

    static var allTests = [
        ("testPart1Case1", testPart1Case1),
        ("testPart2Case1", testPart2Case1),
    ]
}
