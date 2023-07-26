//
//  MOITDetailAppDelegate.swift
//
//  MOITDetail
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
    name: "MOITDetailData",
    platform: .iOS,
    interfaceDependencies: [
        .ThirdParty.RxSwift,
    ],
    implementDependencies: [
        .MOITNetwork.Implement,
    ]
)

