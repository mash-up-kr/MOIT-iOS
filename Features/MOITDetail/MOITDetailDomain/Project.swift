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
    name: "MOITDetailDomain",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
        .Feature.MOITDetail.Data.Interface,
        .DesignSystem,
    ],
    implementDependencies: [
        .Core.MOITFoundation,
		.ThirdParty.RxSwift,
        
        .Feature.MOITList.Data.Interface,
    ]
)

