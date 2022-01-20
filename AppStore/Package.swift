// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppStore",
  platforms: [.iOS(.v12)],
  products: [
    .library( name: "Models", targets: ["Models"]),
    .library( name: "Swifty", targets: ["Swifty"]),
  ],
  dependencies: [
  ],
  targets: [
    .target( name: "Models", dependencies: []),
    .target( name: "Swifty", dependencies: [])
  ]
)
