// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "SWMailgun",
  platforms: [
      .macOS(.v10_13),
      .iOS(.v9),
      .watchOS(.v3),
      .tvOS(.v9)
  ],
  products: [
    .library(
      name: "SWMailgun",
      targets: ["SWMailgun"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/thejohnlima/BaseNetworkKit.git", from: "1.0.9")
  ],
  targets: [
    .target(
      name: "SWMailgun",
      dependencies: ["BaseNetworkKit"]
    ),
    .testTarget(
      name: "SWMailgunTests",
      dependencies: ["SWMailgun"]
    )
  ]
)
