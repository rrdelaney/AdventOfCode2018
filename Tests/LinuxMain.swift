import XCTest

import Day01Tests
import Day02Tests
import Day03Tests
import Day04Tests
import Day05Tests
import Day06Tests
import Day07Tests

var tests = [XCTestCaseEntry]()
tests += Day01Tests.allTests()
tests += Day02Tests.allTests()
tests += Day03Tests.allTests()
tests += Day04Tests.allTests()
tests += Day05Tests.allTests()
tests += Day06Tests.allTests()
tests += Day07Tests.allTests()
XCTMain(tests)
