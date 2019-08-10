import PackageDescription

let package = Package(
    name: "BoxKit",
    products: [
        .library(
            name: "BoxKit",
            targets: ["BoxKit"]),
    ],
    dependencies: [
         .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.2.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "BoxKit",
            dependencies: []),
    ]
)
