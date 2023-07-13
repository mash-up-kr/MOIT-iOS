//
//  SignInAppDelegate.swift
//
//  SignIn
//
//  Created by hyerin
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "SignInUserInterface",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.ThirdParty.RIBs,
		
		.Feature.SignUp.UserInterface.Interface
    ],
    implementDependencies: [
		.ThirdParty.FlexLayout,
		.ThirdParty.PinLayout,
		
		.ResourceKit,
		.DesignSystem,
		
		.Core.Utils,
		
		.Feature.MOITWeb.Interface,
		.Feature.MOITWeb.Implement,
		
		.Feature.SignUp.UserInterface.Implement,
    ],
	demoAppDependencies: [
		.Feature.SignUp.Domain.Interface,
		.Feature.SignUp.Domain.Implement,
	],
    isUserInterface: true
)

