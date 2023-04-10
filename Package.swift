// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "TiledCellKit",
                      platforms: [
                        .iOS(.v13),
                        .watchOS(.v6),
                        .tvOS(.v13),
                      ],
                      products: [
                        .library(name: "TiledCellKit", targets: ["TiledCellKit"]),
                      ],
                      dependencies: [],
                      targets: [
                        .target(name: "TiledCellKit", dependencies: [], path: "TiledCellKit/Classes"),
                      ])
