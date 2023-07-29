//
//  MOITSettingAppDelegate.swift
//
//  MOITSetting
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITSetting",
    interfaceDependencies: [.ThirdParty.RIBs],
    implementDependencies: [
        .ThirdParty.RIBs,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxSwift,
        .ThirdParty.FlexLayout,
        .ThirdParty.PinLayout,
        .ResourceKit,
        .DesignSystem,
    ],
    isUserInterface: true
)
