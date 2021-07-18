// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BoxKit",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "BoxKit", targets: ["BoxKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Flight-School/AnyCodable", .upToNextMajor(from: "0.0.0")),
    ],
    targets: [
        .target(name: "BoxKit", dependencies: ["AnyCodable"]),
        .testTarget(name: "BoxKitTests", dependencies: ["BoxKit"]),
    ]
)
