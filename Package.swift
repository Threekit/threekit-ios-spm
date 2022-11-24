// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Threekit_Framework_Package",
    products: [
        .library(
            name: "Threekit_Framework",
            targets: ["Threekit_Framework"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", branch: "master")
    ],
    targets: [
        .binaryTarget(
            name: "Threekit_Framework",
            path: "./Sources/Threekit_Framework.xcframework")
        ,
    ]
)
