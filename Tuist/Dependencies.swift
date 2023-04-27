//
//  Dependencies.swift
//  Config
//
//  Created by 김찬수.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies(
    [
        .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .branch("master")),
        .remote(url: "https://github.com/uber/RIBs", requirement: .branch("master")),
        .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .branch("master")),
        .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .branch("master")),
        .remote(url: "https://github.com/Quick/Nimble", requirement: .branch("master")),
        .remote(url: "https://github.com/Quick/Quick", requirement: .branch("master")),
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
        "Nimble": .framework,
        "Lottie": .framework,
    ]
)

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
