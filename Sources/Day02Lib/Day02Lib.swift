func letterCounts(_ str: String) -> [Character: Int] {
  var counts = [Character: Int]()

  for letter in str {
    let currentCount = counts[letter] ?? 0
    counts[letter] = currentCount + 1
  }

  return counts
}

public func calculateChecksum(ids: [String]) -> Int {
  var twoLetterCountWordCount = 0
  var threeLetterCountWordCount = 0

  for id in ids {
    let counts = letterCounts(id)

    if counts.values.contains(2) {
      twoLetterCountWordCount += 1
    }

    if counts.values.contains(3) {
      threeLetterCountWordCount += 1
    }
  }

  return twoLetterCountWordCount * threeLetterCountWordCount
}

public func findClosest(ids: [String]) -> String {
  for (index, _) in ids.first!.enumerated() {
    var seenStrs = Set<String>()

    for id in ids {
      var partialStr = id
      let strIndex = partialStr.index(partialStr.startIndex, offsetBy: index)
      partialStr.remove(at: strIndex)

      if seenStrs.contains(partialStr) {
        return partialStr
      } else {
        seenStrs.insert(partialStr)
      }
    }
  }

  return ""
}
