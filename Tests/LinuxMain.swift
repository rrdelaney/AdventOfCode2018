import XCTest

import Day01Tests
import Day02Tests
import Day03Tests

var tests = [XCTestCaseEntry]()
tests += Day01Tests.allTests()
tests += Day02Tests.allTests()
tests += Day03Tests.allTests()
XCTMain(tests)
