//
//  AuthAppDelegate.swift
//
//  Auth
//
//  Created by hyerin
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "AuthUserInterface",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.ThirdParty.RIBs,
		.ThirdParty.RxSwift,
		.ThirdParty.RxRelay,
		
		.Feature.MOITWeb.Interface,
		.Feature.Auth.Domain.Interface,
		
		.TokenManager.Interface
    ],
    implementDependencies: [
		.ThirdParty.RxGesture,
		.ThirdParty.RxCocoa,
		.ThirdParty.FlexLayout,
		.ThirdParty.PinLayout,
		
		.ResourceKit,
		.DesignSystem,
		
		.Core.Utils,
		
		.Feature.Auth.Data.Interface
    ],
	demoAppDependencies: [
		.Feature.MOITWeb.Implement,
		.Feature.Auth.Domain.Implement,
		
		.TokenManager.Implement
	],
    isUserInterface: true
)

