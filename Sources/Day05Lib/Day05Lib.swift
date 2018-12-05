func toggleCase(_ str: String) -> String {
  let upper = str.uppercased()
  let lower = str.lowercased()

  if str == upper {
    return lower
  } else if str == lower {
    return upper
  } else {
    return str
  }
}

func collapse(polymer input: String) -> String {
  var polymer = input
  var isDirty = false

  repeat {
    isDirty = false

    var index = polymer.startIndex
    while index != polymer.endIndex {
      let nextIndex = polymer.index(after: index)
      guard nextIndex != polymer.endIndex else { break }

      let this = String(polymer[index])
      let next = String(polymer[nextIndex])

      if toggleCase(this) == next && this == toggleCase(next) {
        isDirty = true
        polymer.removeSubrange(index...nextIndex)
        if (index != polymer.startIndex) {
          index = polymer.index(before: index)
        }
      } else {
        index = polymer.index(after: index)
      }
    }
  } while isDirty

  return polymer
}

public func collapseAndCount(polymer: String) -> Int {
  return collapse(polymer: polymer).count
}

struct CharPair: Hashable {
  let lowercase: Character
  let uppercase: Character

  static func fromChar(_ ch: Character) -> CharPair {
    let lowercase = Character(String(ch).lowercased())
    let uppercase = Character(String(ch).uppercased())
    return CharPair(lowercase: lowercase, uppercase: uppercase)
  }
}

public func optimizedCollapseAndCount(polymer: String) -> Int {
  let initialCollapsed = collapse(polymer: polymer)
  let removalCandidates = Set(initialCollapsed.map(CharPair.fromChar))
  let optimizedPolymers = removalCandidates.map { (candidate) -> String in
    var copy = polymer
    copy.removeAll(where: { $0 == candidate.lowercase || $0 == candidate.uppercase })
    return copy
  }

  let optimizedCounts = optimizedPolymers.map { optimizedPolymer in
    return collapseAndCount(polymer: optimizedPolymer)
  }

  return optimizedCounts.min()!
}
