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

let project = Project.invertedDualTargetProject(
    name: "MOITAlarmDomain",
    interfaceDependencies: [
        .ThirdParty.RxSwift,
    ],
    implementDependencies: [
        .ThirdParty.RxSwift,
    ]
)

