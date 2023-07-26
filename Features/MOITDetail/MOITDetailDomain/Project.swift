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
    interfaceDependencies: [
        .Feature.MOITDetail.Data.Interface,
    ],
    implementDependencies: [
        .Core.MOITFoundation
    ]
)

