// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shopify",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Shopify",
            targets: ["Shopify"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
		.package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "4.8.2")),
		.package(name: "KeychainSwift", url: "https://github.com/evgenyneu/keychain-swift.git", from: "14.0.0"),
		.package(url: "https://github.com/martyu/mobile-buy-sdk-ios.git", .upToNextMajor(from: "4.0.2")),
		.package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.1")),
		.package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .upToNextMajor(from: "9.0.0")),
		.package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Shopify",
            dependencies: [
				"Alamofire",
				"KeychainSwift",
				.product(name: "mobile-buy-sdk-ios", package: "mobile-buy-sdk-ios"),
				"Nimble",
				.product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs"),
				"Quick"
		],	path: "Shopify/Sources/Shopify"),
        .testTarget(
            name: "ShopifyTests",
            dependencies: ["Shopify"])
    ]
)
