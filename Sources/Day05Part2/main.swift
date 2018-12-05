import Foundation
import Day05Lib

var polymer = ""
while let input = readLine(strippingNewline: true) {
  polymer += input
}

print(Day05Lib.optimizedCollapseAndCount(polymer: polymer))
