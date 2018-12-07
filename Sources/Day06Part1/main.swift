import Foundation
import Day06Lib

var coords: [String] = []
while let input = readLine(strippingNewline: true) {
  coords.append(input)
}

print(Day06Lib.getLargestArea(coords: coords))
