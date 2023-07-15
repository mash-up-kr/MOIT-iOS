//
//  MOITListAppDelegate.swift
//
//  MOITList
//
//  Created by kimchansoo
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITListUserInterface",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
        .ThirdParty.RxSwift,
        .ThirdParty.RIBs,
    ],
    implementDependencies: [
        .ThirdParty.RxSwift,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxRelay,
        .ThirdParty.RIBs,
        .ThirdParty.PinLayout,
        .ThirdParty.FlexLayout,
        .ThirdParty.RxGesture,
    ],
    isUserInterface: true
)

