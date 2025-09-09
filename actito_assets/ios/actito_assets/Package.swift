// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "actito_assets",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "actito-assets", targets: ["actito_assets"])
    ],
    dependencies: [
        .package(url: "git@github.com:actito/actito-sdk-ios-in-house-releases.git", from: "5.0.0-canary.1"),
    ],
    targets: [
        .target(
            name: "actito_assets",
            dependencies: [
                .product(name: "ActitoKit", package: "actito-sdk-ios-in-house-releases", condition: nil),
                .product(name: "ActitoAssetsKit", package: "actito-sdk-ios-in-house-releases", condition: nil),
            ],
        ),
    ]
)
