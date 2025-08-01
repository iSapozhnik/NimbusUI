// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NimbusUI",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NimbusUI",
            targets: ["NimbusUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Cindori/FluidGradient.git", from: "1.0.0"),
//        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", upToNextMajor: "1.18.6"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", .upToNextMajor(from: "1.18.6"))

    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NimbusUI",
            dependencies: [
                .product(name: "FluidGradient", package: "FluidGradient")
            ]
        ),
        .testTarget(
            name: "NimbusUITests",
            dependencies: [
                "NimbusUI",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        ),
    ]
)
