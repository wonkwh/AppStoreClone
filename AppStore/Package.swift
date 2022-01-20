// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppStore",
  platforms: [.iOS(.v13)],
  products: [
    .library( name: "Models", targets: ["Models"]),
    .library( name: "Swifty", targets: ["Swifty"]),
    .library( name: "ApiClient", targets: ["ApiClient"]),
  ],
  dependencies: [
    .package(name: "Get", url: "https://github.com/kean/Get", from: "0.4.0")
  ],
  targets: [
    .target( name: "Models", dependencies: []),
    .target( name: "Swifty", dependencies: []),
    .target(name: "ApiClient", dependencies: [
      .product(name: "Get", package: "Get")
    ]),
  ]
)
