// swift-tools-version: 5.8

import PackageDescription

let settings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

let package = Package(
	name: "Welp",
	platforms: [.macOS(.v10_15)],
	products: [
		.library(name: "Welp", targets: ["Welp"]),
	],
	dependencies: [
	],
	targets: [
		.target(name: "Welp", dependencies: [], swiftSettings: settings),
		.testTarget(name: "WelpTests", dependencies: ["Welp"], swiftSettings: settings),
	]
)
