//
//  MOITShareAppDelegate.swift
//
//  MOITShare
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITShare",
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

