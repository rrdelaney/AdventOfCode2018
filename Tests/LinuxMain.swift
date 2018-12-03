import XCTest

import Day01Tests
import Day02Tests

var tests = [XCTestCaseEntry]()
tests += Day01Tests.allTests()
tests += Day02Tests.allTests()
XCTMain(tests)
