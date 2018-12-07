import Foundation

struct Point: Hashable {
  let x: Int
  let y: Int
}

struct Claim {
  let id: String
  let loc: Point
  let height: Int
  let width: Int

  static func fromString(_ claim: String) -> Claim {
    let split1 = claim.components(separatedBy: " @ ")
    let id = String(split1[0].dropFirst())
    let split2 = split1[1].components(separatedBy: ",")
    let x = split2[0]
    let split3 = split2[1].components(separatedBy: ": ")
    let y = split3[0]
    let split4 = split3[1].components(separatedBy: "x")
    let width = split4[0]
    let height = split4[1]

    let loc = Point(x: Int(x)!, y: Int(y)!)
    return Claim(id: id, loc: loc, height: Int(height)!, width: Int(width)!)
  }
}

func buildClaimGrid(claims: [Claim]) -> [Point: Set<String>] {
  var grid: [Point: Set<String>] = [:]

  for claim in claims {
    let minX = claim.loc.x
    let maxX = claim.loc.x + claim.width - 1
    let minY = claim.loc.y
    let maxY = claim.loc.y + claim.height - 1

    for x in minX...maxX {
      for y in minY...maxY {
        let loc = Point(x: x, y: y)
        if let _ = grid[loc] {
          grid[loc]!.insert(claim.id)
        } else {
          grid[loc] = [claim.id]
        }
      }
    }
  }

  return grid
}

public func numOverlappingClaims(claims claimStrs: [String]) -> Int {
  let claims = claimStrs.map(Claim.fromString)
  let grid = buildClaimGrid(claims: claims)
  return grid.values.filter({ $0.count >= 2 }).count
}

public func findNonoverlappingClaim(claims claimStrs: [String]) -> String {
  let claims = claimStrs.map(Claim.fromString)
  let grid = buildClaimGrid(claims: claims)

  var idsWithSomeOverlap: Set<String> = []
  var idsWithNoOverlap: Set<String> = []

  for (_, seenIds) in grid {
    if seenIds.count > 1 {
      idsWithSomeOverlap.formUnion(seenIds)
    } else {
      idsWithNoOverlap.formUnion(seenIds)
    }
  }

  idsWithNoOverlap.subtract(idsWithSomeOverlap)
  if idsWithNoOverlap.count == 1 {
    return idsWithNoOverlap.first!
  } else {
    return ""
  }
}
