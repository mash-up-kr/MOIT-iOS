//
//  MOITListAppDelegate.swift
//
//  MOITList
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
    name: "MOITListDomain",
    platform: .iOS,
    interfaceDependencies: [
        .ThirdParty.RxSwift,
        
    ],
    implementDependencies: [
        .ThirdParty.RxSwift,
        
        .Feature.MOITList.Data.Interface,
    ]
)

