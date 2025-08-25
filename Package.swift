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
            name: "NimbusCore",
            targets: ["NimbusCore"]),
        .library(
            name: "NimbusComponents", 
            targets: ["NimbusComponents"]),
        .library(
            name: "NimbusNotifications",
            targets: ["NimbusNotifications"]),
        .library(
            name: "NimbusOnboarding",
            targets: ["NimbusOnboarding"]),
        .library(
            name: "NimbusBezel",
            targets: ["NimbusBezel"]),
        .library(
            name: "NimbusAlerts",
            targets: ["NimbusAlerts"]),
        // Convenience umbrella library
        .library(
            name: "NimbusUI",
            targets: [
                "NimbusCore",
                "NimbusComponents",
                "NimbusNotifications",
                "NimbusOnboarding",
                "NimbusBezel",
                "NimbusAlerts"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Cindori/FluidGradient.git", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", .upToNextMajor(from: "1.18.6")),
        .package(url: "https://github.com/raymondjavaxx/SmoothGradient.git", .upToNextMajor(from: "1.0.1"))

    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        
        // Core foundation - theme system, utilities, base modifiers
        .target(
            name: "NimbusCore",
            dependencies: []
        ),
        
        // Main components - buttons, checkbox, list, scroll
        .target(
            name: "NimbusComponents",
            dependencies: ["NimbusCore"]
        ),
        
        // Optional notification system
        .target(
            name: "NimbusNotifications", 
            dependencies: ["NimbusCore", "NimbusComponents"]
        ),
        
        // Optional onboarding system with external dependencies
        .target(
            name: "NimbusOnboarding",
            dependencies: [
                "NimbusCore",
                "NimbusComponents",
                .product(name: "FluidGradient", package: "FluidGradient"),
                .product(name: "SmoothGradient", package: "SmoothGradient")
            ]
        ),
        
        // Optional bezel system
        .target(
            name: "NimbusBezel",
            dependencies: ["NimbusCore"]
        ),
        
        // Optional alert system
        .target(
            name: "NimbusAlerts",
            dependencies: ["NimbusCore", "NimbusComponents"]
        ),
        
        // Test targets
        .testTarget(
            name: "NimbusCoreTests",
            dependencies: [
                "NimbusCore",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
        .testTarget(
            name: "NimbusComponentsTests", 
            dependencies: [
                "NimbusCore",
                "NimbusComponents",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
        .testTarget(
            name: "NimbusNotificationsTests",
            dependencies: [
                "NimbusCore",
                "NimbusNotifications", 
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
        .testTarget(
            name: "NimbusOnboardingTests",
            dependencies: [
                "NimbusCore",
                "NimbusOnboarding",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
        .testTarget(
            name: "NimbusBezelsTests",
            dependencies: [
                "NimbusCore",
                "NimbusBezel",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
        .testTarget(
            name: "NimbusAlertsTests",
            dependencies: [
                "NimbusCore",
                "NimbusAlerts",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
        .testTarget(
            name: "NimbusUITests",
            dependencies: [
                "NimbusCore",
                "NimbusComponents", 
                "NimbusNotifications",
                "NimbusOnboarding",
                "NimbusBezel",
                "NimbusAlerts",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
        ),
    ]
)
