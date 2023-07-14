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
		.ThirdParty.RxRelay
    ],
    implementDependencies: [
		.ThirdParty.RxGesture,
		.ThirdParty.RxCocoa,
		.ThirdParty.FlexLayout,
		.ThirdParty.PinLayout,
		
		.ResourceKit,
		.DesignSystem,
		
		.Core.Utils,

		.Feature.Auth.Domain.Interface,
		.Feature.Auth.Data.Interface
    ],
    isUserInterface: true
)

