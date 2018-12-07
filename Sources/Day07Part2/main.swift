import Foundation
import Day07Lib

var steps: [String] = []
while let input = readLine(strippingNewline: true) {
  steps.append(input)
}

print(Day07Lib.getTimeForComputation(steps: steps, numWorkers: 5, taskStartupDelay: 60))
