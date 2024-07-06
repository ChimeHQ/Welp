// swift-tools-version: 5.8

import PackageDescription

let package = Package(
	name: "Welp",
	platforms: [.macOS(.v10_15)],
	products: [
		.executable(name: "welp", targets: ["clitool"]),
		.library(name: "Welp", targets: ["Welp"]),
		.library(name: "WelpBook", targets: ["WelpBook"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.3"),
	],
	targets: [
		.executableTarget(name: "clitool", dependencies: [
			"Welp",
			.product(name: "ArgumentParser", package: "swift-argument-parser"),
		]),
		.target(name: "Welp", dependencies: []),
		.target(name: "WelpBook", dependencies: []),
		.testTarget(name: "WelpTests", dependencies: ["Welp"]),
	]
)

let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency"),
	.enableExperimentalFeature("GlobalActorIsolatedTypesUsability"),
]

for target in package.targets {
	var settings = target.swiftSettings ?? []
	settings.append(contentsOf: swiftSettings)
	target.swiftSettings = settings
}
