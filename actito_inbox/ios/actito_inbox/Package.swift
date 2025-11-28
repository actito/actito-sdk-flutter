// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "actito_inbox",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "actito-inbox", targets: ["actito_inbox"])
    ],
    dependencies: [
        .package(url: "https://github.com/Actito/actito-sdk-ios.git", from: "5.0.0-beta.1"),
    ],
    targets: [
        .target(
            name: "actito_inbox",
            dependencies: [
                .product(name: "ActitoKit", package: "actito-sdk-ios", condition: nil),
                .product(name: "ActitoInboxKit", package: "actito-sdk-ios", condition: nil),
            ],
        ),
    ]
)
