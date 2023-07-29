//
//  MOITDetail.swift
//
//  MOITDetail
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITDetail",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
        .ThirdParty.RIBs,
		.Feature.MOITDetail.Domain.Interface,
		.Feature.MOITDetail.Data.Interface,
		.Feature.Fine.Domain.Interface,
		.MOITNetwork.Interface
    ],
    implementDependencies: [
        .ThirdParty.Kingfisher,
        .ThirdParty.RxSwift,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxRelay,
        .ThirdParty.RxGesture,
        .ThirdParty.FlexLayout,
        .ThirdParty.PinLayout,
        .ThirdParty.SkeletonView,
        .ResourceKit,
        .DesignSystem,
        .Feature.MOITDetail.Domain.Implement,
        .Feature.MOITDetail.Data.Implement,
		.Feature.Fine.UserInterface.Interface,
		.Feature.Fine.UserInterface.Implement,
        .Feature.Fine.Domain.Interface,
        .Feature.Fine.Domain.Implement,
        .Feature.Fine.Data.Interface,
        .Feature.Fine.Data.Implement,
        .ThirdParty.Collections,
    ],
	demoAppDependencies: [
		.Feature.Fine.Domain.Interface,
		.Feature.Fine.Domain.Implement,
		.Feature.Fine.Data.Interface,
		.Feature.Fine.Data.Implement,
		.TokenManager.Implement
	],
    isUserInterface: true
)

