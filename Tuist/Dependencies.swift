//
//  Dependencies.swift
//  Config
//
//  Created by 김찬수.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies(
    [
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from:"6.0.0")),
        .remote(url: "https://github.com/uber/RIBs", requirement: .upToNextMajor(from: "0.14.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.2.0")),
        .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "4.2.0")),
        .remote(url: "https://github.com/Quick/Nimble", requirement: .upToNextMajor(from: "9.2.0")),
        .remote(url: "https://github.com/Quick/Quick", requirement: .upToNextMajor(from: "5.0.0")),
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
    ]
)

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
