// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "Welp",
	platforms: [.macOS(.v10_13)],
    products: [
        .library(name: "Welp", targets: ["Welp"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Welp", dependencies: []),
        .testTarget(name: "WelpTests", dependencies: ["Welp"]),
    ]
)
