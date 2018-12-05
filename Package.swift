// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2018",
    dependencies: [],
    targets: [
        .target(name: "Day01Lib", dependencies: []),
        .target(name: "Day01Part1", dependencies: ["Day01Lib"]),
        .target(name: "Day01Part2", dependencies: ["Day01Lib"]),
        .testTarget(name: "Day01Tests", dependencies: ["Day01Lib"]),
        .target(name: "Day02Lib", dependencies: []),
        .target(name: "Day02Part1", dependencies: ["Day02Lib"]),
        .target(name: "Day02Part2", dependencies: ["Day02Lib"]),
        .testTarget(name: "Day02Tests", dependencies: ["Day02Lib"]),
        .target(name: "Day03Lib", dependencies: []),
        .target(name: "Day03Part1", dependencies: ["Day03Lib"]),
        .target(name: "Day03Part2", dependencies: ["Day03Lib"]),
        .testTarget(name: "Day03Tests", dependencies: ["Day03Lib"]),
        .target(name: "Day04Lib", dependencies: []),
        .target(name: "Day04Part1", dependencies: ["Day04Lib"]),
        .target(name: "Day04Part2", dependencies: ["Day04Lib"]),
        .testTarget(name: "Day04Tests", dependencies: ["Day04Lib"]),
    ]
)
