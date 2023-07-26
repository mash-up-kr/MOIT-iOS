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
    name: "FineDomain",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.Feature.MOITDetail.Domain.Interface,
		.Feature.Fine.Data.Interface,
		.ThirdParty.RxSwift
    ],
    implementDependencies: [
    ]
)

