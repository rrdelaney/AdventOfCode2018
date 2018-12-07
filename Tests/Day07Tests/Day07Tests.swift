import XCTest
@testable import Day07Lib

final class Day07Tests: XCTestCase {
    func testPart1Case1() {
      let steps = [
        "Step C must be finished before step A can begin.",
        "Step C must be finished before step F can begin.",
        "Step A must be finished before step B can begin.",
        "Step A must be finished before step D can begin.",
        "Step B must be finished before step E can begin.",
        "Step D must be finished before step E can begin.",
        "Step F must be finished before step E can begin.",
      ]

      let order = Day07Lib.getComputationOrder(steps: steps)
      XCTAssertEqual(order, "CABDFE")
    }

    func testPart2Case1() {
      let steps = [
        "Step C must be finished before step A can begin.",
        "Step C must be finished before step F can begin.",
        "Step A must be finished before step B can begin.",
        "Step A must be finished before step D can begin.",
        "Step B must be finished before step E can begin.",
        "Step D must be finished before step E can begin.",
        "Step F must be finished before step E can begin.",
      ]

      let timeToComplete = Day07Lib.getTimeForComputation(steps: steps, numWorkers: 2, taskStartupDelay: 0)
      XCTAssertEqual(timeToComplete, 15)
    }


    static var allTests = [
        ("testPart1Case1", testPart1Case1),
        ("testPart2Case1", testPart2Case1),
    ]
}
