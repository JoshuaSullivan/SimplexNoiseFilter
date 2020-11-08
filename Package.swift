// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimplexNoiseFilter",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "SimplexNoiseFilter",
            targets: ["SimplexNoiseFilter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SimplexNoiseFilter",
            dependencies: [],
            resources: [
                .copy("SimplexNoise.ci.metallib"),
            ]),
    ]
)
