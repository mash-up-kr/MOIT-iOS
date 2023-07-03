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

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITParticipateUserInterface",
    platform: .iOS,
    iOSTargetVersion: "15.0.0",
    interfaceDependencies: [
    ],
    implementDependencies: [
		.ThirdParty.RIBs,
		.ThirdParty.PinLayout,
		.ThirdParty.FlexLayout,
		.ThirdParty.RxCocoa,
		.ThirdParty.RxSwift,
		
		.Core.Utils,
		.ResourceKit,
		.DesignSystem,
    ],
    isUserInterface: true
)

