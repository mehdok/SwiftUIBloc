// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIBloc",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v14),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftUIBloc",
            targets: ["SwiftUIBloc"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/groue/CombineExpectations.git", from: "0.10.0"),
        .package(url: "https://github.com/nalexn/ViewInspector", from: "0.8.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftUIBloc",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftUIBlocTests",
            dependencies: [
                "SwiftUIBloc",
                "CombineExpectations",
                "ViewInspector",
            ]
        ),
    ]
)
