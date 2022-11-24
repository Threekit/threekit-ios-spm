// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Threekit_Framework_Package",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Threekit_Framework_Package",
            targets: ["Threekit_Framework_Package"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Threekit_Framework_Package",
            dependencies: []),
        .testTarget(
            name: "Threekit_Framework_PackageTests",
            dependencies: ["Threekit_Framework_Package"]),
    ]
)
