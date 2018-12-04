import XCTest
@testable import Day03Lib

final class Day03Tests: XCTestCase {
    func testPart1Case1() {
      let claims = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]
      let numOverlap = Day03Lib.numOverlappingClaims(claims: claims)
      XCTAssertEqual(numOverlap, 4)
    }

    func testPart2Case1() {
      let claims = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]
      let noOverlap = Day03Lib.findNonoverlappingClaim(claims: claims)
      XCTAssertEqual(noOverlap, "3")
    }

    static var allTests = [
        ("testPart1Case1", testPart1Case1),
        ("testPart2Case1", testPart2Case1),
    ]
}
