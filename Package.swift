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
    ]
)