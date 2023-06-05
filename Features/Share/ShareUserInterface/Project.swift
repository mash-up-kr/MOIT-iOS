//
//  ShareAppDelegate.swift
//
//  Share
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "Share",
    platform: .iOS,
    iOSTargetVersion: "15.0.0",
    interfaceDependencies: [
    ],
    implementDependencies: [
        .ThirdParty.RIBs,
        .ThirdParty.PinLayout,
        .ThirdParty.FlexLayout,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxSwift,
        .ThirdParty.RxGesture,
        .ResourceKit,
        .DesignSystem,
    ],
    isUserInterface: true
)

