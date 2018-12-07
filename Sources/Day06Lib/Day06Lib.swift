import Foundation

struct Point: Hashable {
  let x: Int
  let y: Int
}

func parseCoord(from: String) -> Point {
  let parts = from.components(separatedBy: ", ")
  return Point(x: Int(parts[0])!, y: Int(parts[1])!)
}

func buildCoordGrid(points: [Point]) -> [Point: Point?] {
  var grid: [Point: Point?] = [:]
  var pointsTouchingBorder: Set<Point> = []

  let xVals = points.map { $0.x }
  let yVals = points.map { $0.y }
  let minX = xVals.min()!
  let maxX = xVals.max()!
  let minY = yVals.min()!
  let maxY = yVals.max()!

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
  let coords = coorStrs.map(parseCoord)
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
  let coords = coorStrs.map(parseCoord)
  var safePoints: Set<Point> = []

  let xVals = coords.map { $0.x }
  let yVals = coords.map { $0.y }
  let minX = xVals.min()!
  let maxX = xVals.max()!
  let minY = yVals.min()!
  let maxY = yVals.max()!

  for x in minX...maxX {
    checkPoint: for y in minY...maxY {
      var totalDistance = 0
      for point in coords {
        let dx = abs(point.x - x)
        let dy = abs(point.y - y)
        totalDistance += dx + dy

        if totalDistance >= maxDistance {
          continue checkPoint
        }
      }

      safePoints.insert(Point(x: x, y: y))
    }
  }

  return safePoints.count
}
