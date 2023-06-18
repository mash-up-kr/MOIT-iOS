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
    iOSTargetVersion: "15.0.0",
    interfaceDependencies: [
        .Feature.MOITDetail.Data.Interface,
        .Feature.MOITDetail.Data.Implement,
    ],
    implementDependencies: [
        .Feature.MOITDetail.Data.Interface,
        .Feature.MOITDetail.Data.Implement,
    ]
)

