import Foundation
import Day01Lib

var freqs: [Int] = []
while let input = readLine(strippingNewline: true) {
  freqs.append(Int(input)!)
}

print(Day01Lib.findFirstRecurringFreq(freqs: freqs))
