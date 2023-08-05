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
    interfaceDependencies: [
        .ThirdParty.RIBs,
        .Feature.Auth.Domain.Interface,
    ],
    implementDependencies: [
        .ThirdParty.RIBs,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxSwift,
        .ThirdParty.FlexLayout,
        .ThirdParty.PinLayout,
        .ResourceKit,
        .DesignSystem,
        .Feature.MOITWeb.Implement,
        .Feature.MOITWeb.Interface,
        .Feature.Auth.Domain.Interface,
        .Core.MOITFoundation,
    ],
    isUserInterface: true
)
