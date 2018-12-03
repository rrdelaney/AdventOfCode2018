import Foundation
import Day02Lib

var ids: [String] = []
while let input = readLine(strippingNewline: true) {
  ids.append(input)
}

print(Day02Lib.findClosest(ids: ids))
