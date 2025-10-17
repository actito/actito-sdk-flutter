// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "actito_push_ui",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "actito-push-ui", targets: ["actito_push_ui"])
    ],
    dependencies: [
        .package(url: "git@github.com:actito/actito-sdk-ios-in-house-releases.git", from: "5.0.0-canary.5"),
    ],
    targets: [
        .target(
            name: "actito_push_ui",
            dependencies: [
                .product(name: "ActitoKit", package: "actito-sdk-ios-in-house-releases", condition: nil),
                .product(name: "ActitoPushUIKit", package: "actito-sdk-ios-in-house-releases", condition: nil),
            ],
        ),
    ]
)
