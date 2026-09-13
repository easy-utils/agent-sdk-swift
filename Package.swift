// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "agent-sdk-swift",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [.library(name: "AgentSDK", targets: ["AgentSDK"])],
    dependencies: [
        .package(path: "/home/user/easy-utils/easy-rpc-swift"),
    ],
    targets: [
        .target(name: "AgentSDK", dependencies: [
            .product(name: "easyRpc", package: "easy-rpc-swift"),
        ], path: "Sources/AgentSDK"),
    ]
)
