//
//  MOITAlarmAppDelegate.swift
//
//  MOITAlarm
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITAlarm",
    interfaceDependencies: [
        .ThirdParty.RIBs
    ],
    implementDependencies: [
        .ThirdParty.RIBs,
        .ThirdParty.RxSwift,
        .ThirdParty.RxCocoa,
        .Feature.MOITAlarm.Data.Interface,
        .Feature.MOITAlarm.Domain.Interface,
    ],
    isUserInterface: true
)

