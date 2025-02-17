// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AIGenerator",
    dependencies: [],
    targets: [
        .executableTarget(
            name: "AIGenerator",
            dependencies: [],
            exclude: [
                "Package_MVVMViewBuilder/MVVMExample/",
                "Package_EnvironmentRouterNavigation/EnvironmentRouterExample/",
                "Package_NetworkingAsyncEndpointDescriptor/NetworkingExample/"
            ]
        ),
    ]
)

