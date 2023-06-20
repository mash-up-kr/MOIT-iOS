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
    iOSTargetVersion: "15.0.0",
    interfaceDependencies: [
		.ThirdParty.RIBs
    ],
    implementDependencies: [
		.ThirdParty.RIBs,
		.ThirdParty.FlexLayout,
		.ThirdParty.PinLayout,
		.ThirdParty.KakaoSDKUser,
		.ThirdParty.RxKakaoSDKUser,
		.ResourceKit,
		.DesignSystem
    ],
    isUserInterface: true
)

