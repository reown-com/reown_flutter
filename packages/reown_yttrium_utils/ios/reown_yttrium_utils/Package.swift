// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "reown_yttrium_utils",
  platforms: [
    .iOS("13.0")
  ],
  products: [
    .library(name: "reown-yttrium-utils", targets: ["reown_yttrium_utils"])
  ],
  dependencies: [
    // Keep in step with the YttriumUtilsWrapper pod version in ../reown_yttrium_utils.podspec
    // and with the Yttrium version in walletconnect_pay's Package.swift: Swift Package Manager
    // resolves one version of the yttrium package per app.
    .package(url: "https://github.com/reown-com/yttrium", exact: "0.10.59")
  ],
  targets: [
    .target(
      name: "reown_yttrium_utils",
      dependencies: [
        .product(name: "YttriumUtils", package: "yttrium")
      ],
      resources: [
        .process("PrivacyInfo.xcprivacy")
      ]
    )
  ]
)
