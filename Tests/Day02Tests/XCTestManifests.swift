import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Day02Tests.allTests),
    ]
}
#endif
