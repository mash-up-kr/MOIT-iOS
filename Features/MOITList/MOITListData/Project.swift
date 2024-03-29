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

let project = Project.invertedDualTargetProject(
    name: "MOITListData",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
        .ThirdParty.RxSwift,
        
        .Feature.MOITList.Domain.Interface,
        .MOITNetwork.Interface,
    ],
    implementDependencies: [
        .ThirdParty.RxSwift,
    ]
)

