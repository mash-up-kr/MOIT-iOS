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

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "FineUserInterface",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.ThirdParty.RIBs,
		.Feature.Fine.Domain.Interface
    ],
    implementDependencies: [
		.ThirdParty.FlexLayout,
		.ThirdParty.PinLayout,
		.ThirdParty.RxCocoa,
		.ThirdParty.RxSwift,
		.ThirdParty.Kingfisher,
		.Core.Utils,
		.DesignSystem,
		.ResourceKit
    ],
	demoAppDependencies: [
		.Feature.Fine.Domain.Implement,
		.Feature.Fine.Data.Interface,
		.Feature.Fine.Data.Implement,
		.Feature.MOITDetail.Domain.Interface,
		.Feature.MOITDetail.Domain.Implement,
		.MOITNetwork.Interface,
		.MOITNetwork.Implement,
		.TokenManager.Implement
	],
    isUserInterface: true
)

