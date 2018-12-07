import Foundation

struct Point: Hashable {
  let x: Int
  let y: Int

  func distanceFrom(_ other: Point) -> Int {
    return abs(other.x - self.x) + abs(other.y - self.y)
  }

  static func fromString(_ from: String) -> Point {
    let parts = from.components(separatedBy: ", ")
    return Point(x: Int(parts[0])!, y: Int(parts[1])!)
  }
}

func buildCoordGrid(points: [Point]) -> [Point: Point?] {
  var grid: [Point: Point?] = [:]
  var pointsTouchingBorder: Set<Point> = []

  let minX = points.map({ $0.x }).min()!
  let maxX = points.map({ $0.x }).max()!
  let minY = points.map({ $0.y }).min()!
  let maxY = points.map({ $0.y }).max()!

  for x in minX...maxX {
    for y in minY...maxY {
      var closestPoints: Set<Point> = []
      var closestPointDistance = Int.max

      for point in points {
        let dx = abs(point.x - x)
        let dy = abs(point.y - y)
        let d = dx + dy

        if d < closestPointDistance {
          closestPoints = [point]
          closestPointDistance = d
        } else if d == closestPointDistance {
          closestPoints.insert(point)
        }
      }

      let currentPoint = Point(x: x, y: y)
      if closestPoints.count > 1 {
        grid[currentPoint] = nil
      } else {
        grid[currentPoint] = closestPoints.first!

        if x == minX || x == maxX || y == minY || y == maxY {
          pointsTouchingBorder.formUnion(closestPoints)
        }
      }
    }
  }

  for (point, maybeClosestPoint) in grid {
    if let closestPoint = maybeClosestPoint {
      if pointsTouchingBorder.contains(closestPoint) {
        grid[point] = nil
      }
    }
  }

  return grid
}

public func getLargestArea(coords coorStrs: [String]) -> Int {
  let coords = coorStrs.map(Point.fromString)
  let grid = buildCoordGrid(points: coords)

  var areaSizes: [Point: Int] = [:]
  for (_, closestPoint) in grid {
    if let point = closestPoint {
      if let count = areaSizes[point] {
        areaSizes[point] = count + 1
      } else {
        areaSizes[point] = 1
      }
    }
  }

  return areaSizes.values.max() ?? 0
}

public func getSafeArea(coords coorStrs: [String], maxDistance: Int) -> Int {
  let coords = coorStrs.map(Point.fromString)

  let minX = coords.map({ $0.x }).min()!
  let maxX = coords.map({ $0.x }).max()!
  let minY = coords.map({ $0.y }).min()!
  let maxY = coords.map({ $0.y }).max()!

  let range = (minX...maxX).flatMap { x in
    (minY...maxY).map { y in
      Point(x: x, y: y)
    }
  }

  let safePoints = range.filter { r in
    let totalDistance = coords
      .map({ $0.distanceFrom(r) })
      .reduce(0, +)

    return totalDistance < maxDistance
  }

  return safePoints.count
}
