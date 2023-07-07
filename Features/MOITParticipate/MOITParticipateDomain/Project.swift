//
//  MOITParticipateAppDelegate.swift
//
//  MOITParticipate
//
//  Created by hyerin
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
    name: "MOITParticipateDomain",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.Feature.MOITParticipate.Data.Interface
    ],
    implementDependencies: [
		.Feature.MOITParticipate.Data.Interface
    ]
)

