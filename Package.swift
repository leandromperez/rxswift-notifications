// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "RxSwiftNotifications",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "RxSwiftNotifications", targets: ["RxSwiftNotifications"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "RxSwiftNotifications",
            dependencies: ["RxSwift", "RxCocoa"],
            path: "RxSwiftNotifications/Classes"
        ),
        .target(
            name: "RxSwiftNotificationsTests",
            dependencies: ["RxSwift", "RxCocoa", "RxSwiftNotifications"],
            path: "RxSwiftNotifications/Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
