//
//  Dependencies.swift
//  Config
//
//  Created by 김찬수.
//

import ProjectDescription

let carthageDep = CarthageDependencies([
    .github(
        path: "layoutBox/PinLayout",
        requirement: .upToNext("1.10.1")
    ),
    .github(
        path: "layoutBox/FlexLayout",
        requirement: .upToNext("1.3.18")
    ),
])

let spm = SwiftPackageManagerDependencies(
    [
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from:"6.0.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMinor(from: "4.0.0")),
        .remote(url: "https://github.com/uber/RIBs", requirement: .upToNextMajor(from: "0.14.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.2.0")),
        .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "4.2.0")),
        .remote(url: "https://github.com/Quick/Nimble", requirement: .upToNextMajor(from: "9.2.0")),
        .remote(url: "https://github.com/Quick/Quick", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/Juanpe/SkeletonView", requirement: .upToNextMajor(from: "1.30.0")),
        .remote(url: "https://github.com/apple/swift-collections", requirement: .branch("main")),
		.remote(url: "https://github.com/scalessec/Toast-Swift.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "10.12.0")),
    ],
    productTypes: [
        "RIBs": .framework,
        "RxSwift": .framework,
        "RxCocoa": .framework,
        "RxRelay": .framework,
        "RxGesture": .framework,
        "Kingfisher": .framework,
        "Nimble": .framework,
        "Quick": .framework,
        "Lottie": .framework,
        "SkeletonView": .framework,
        "Collections": .framework,
		"Toast": .framework
    ]
)

let dependencies = Dependencies(
    carthage: carthageDep,
    swiftPackageManager: spm,
    platforms: [.iOS]
)
