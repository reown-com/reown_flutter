// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "walletconnect_pay",
  platforms: [
    .iOS("13.0")
  ],
  products: [
    .library(name: "walletconnect-pay", targets: ["walletconnect_pay"])
  ],
  dependencies: [
    // Keep in step with the YttriumWrapper pod version in ../walletconnect_pay.podspec.
    .package(url: "https://github.com/reown-com/yttrium", exact: "0.10.59")
  ],
  targets: [
    .target(
      name: "walletconnect_pay",
      dependencies: [
        .product(name: "Yttrium", package: "yttrium")
      ],
      resources: [
        .process("PrivacyInfo.xcprivacy")
      ]
    )
  ]
)
