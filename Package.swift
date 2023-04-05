// swift-tools-version:5.7.0
import PackageDescription

let package = Package(
    name: "YXWaveView",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "YXWaveView",
            targets: ["YXWaveView"]),
    ],
    targets: [
        .target(
            name: "YXWaveView",
            path: "YXWaveView"
        )
    ]
)