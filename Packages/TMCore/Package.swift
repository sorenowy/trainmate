// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TMCore",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TMCore",
            targets: ["TMCore"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TMCore",
            path: "Sources/TMCore"
        ),
        .testTarget(
            name: "TMCoreTests",
            dependencies: ["TMCore"],
            path: "Tests/TMCoreTests"
        ),
    ],
    swiftLanguageModes: [.v6]
)
