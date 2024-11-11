// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "grokkoli",
    platforms: [
        .iOS(.v17)
    ],
    dependencies: [
        // Add any required dependencies here
    ],
    targets: [
        .target(
            name: "grokkoli",
            dependencies: [],
            resources: [
                .process("AppResources/Assets.xcassets"),
                .process("AppResources/Preview Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "grokkoliTests",
            dependencies: ["grokkoli"]
        )
    ]
)
