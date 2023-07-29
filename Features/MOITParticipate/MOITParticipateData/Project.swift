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
    name: "MOITParticipateData",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.Feature.MOITDetail.Data.Interface,
		
		.MOITNetwork.Interface,
		.ThirdParty.RxSwift
    ],
    implementDependencies: [
    ]
)

