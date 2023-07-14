//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송서영 on 2023/05/22.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITWeb",
    interfaceDependencies: [
        .ThirdParty.RIBs
    ],
    implementDependencies: [
        .ThirdParty.PinLayout,
        .ThirdParty.FlexLayout
    ],
	demoAppDependencies: [
		.Feature.Auth.Domain.Interface
	],
    useTestTarget: true,
    isUserInterface: true
)
