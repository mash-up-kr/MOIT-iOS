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
        .ThirdParty.RIBs,
		.Feature.Auth.Domain.Interface
    ],
    implementDependencies: [
        .ThirdParty.PinLayout,
        .ThirdParty.FlexLayout,
		.Core.CSLogger,
		.Core.Utils,
        .Feature.MOITShare.Implement,
        .Feature.MOITShare.Interface,
        .ThirdParty.FirebaseMessaging,
		.ThirdParty.Toast,
        
    ],
    useTestTarget: true,
    isUserInterface: true
)
