public func findFreqDrift(freqs: [Int]) -> Int {
  return freqs.reduce(0, { prev, curr in
    prev + curr
  })
}

public func findFirstRecurringFreq(freqs: [Int]) -> Int {
  var currentIndex = 0
  var currentFreq = 0
  var seenFreqs = Set<Int>()

  while !seenFreqs.contains(currentFreq) {
    seenFreqs.insert(currentFreq)
    currentFreq += freqs[currentIndex]
    currentIndex += 1

    if currentIndex == freqs.count {
      currentIndex = 0
    }
  }

  return currentFreq
}
