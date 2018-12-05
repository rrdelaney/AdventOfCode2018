import Foundation
import Day04Lib

var events: [String] = []
while let input = readLine(strippingNewline: true) {
  events.append(input)
}

print(Day04Lib.getStrategy2Guard(events: events))
