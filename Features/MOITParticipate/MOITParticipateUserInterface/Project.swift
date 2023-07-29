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
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.Feature.MOITDetail.Domain.Interface,
		
		.MOITNetwork.Interface,
		
		.ThirdParty.RIBs,
    ],
    implementDependencies: [
		.ThirdParty.PinLayout,
		.ThirdParty.FlexLayout,
		.ThirdParty.RxCocoa,
		.ThirdParty.RxSwift,
		.ThirdParty.Toast,
		
		.Core.Utils,
		.ResourceKit,
		.DesignSystem,
		
		.Feature.MOITParticipate.Domain.Interface,
		.Feature.MOITParticipate.Data.Interface,
		.Feature.MOITDetail.Interface
    ],
	demoAppDependencies: [
		.Feature.MOITParticipate.Domain.Implement,
		.Feature.MOITParticipate.Data.Implement,
		.Feature.MOITDetail.Domain.Interface,
		.Feature.MOITDetail.Domain.Implement,
		.Feature.MOITDetail.Data.Interface,
		.Feature.MOITDetail.Data.Implement,
		
		.MOITNetwork.Implement
	],
    isUserInterface: true
)

