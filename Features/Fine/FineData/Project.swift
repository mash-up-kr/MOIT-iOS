//
//  FineAppDelegate.swift
//
//  Fine
//
//  Created by hyerin
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
    name: "FineData",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.ThirdParty.RxSwift
    ],
    implementDependencies: [
		.MOITNetwork.Interface
    ]
)

