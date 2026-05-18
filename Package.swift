// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftui-table-demo",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "swiftui-table-demo",
            targets: ["swiftui-table-demo"]
        )
    ],
    targets: [
        .executableTarget(
            name: "swiftui-table-demo",
            path: "Sources"
        ),
    ]
)
