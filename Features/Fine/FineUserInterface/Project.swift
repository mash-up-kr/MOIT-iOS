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
    iOSTargetVersion: "15.0.0",
    interfaceDependencies: [
		.ThirdParty.RIBs
    ],
    implementDependencies: [
		.ThirdParty.RIBs,
		.ThirdParty.FlexLayout,
		.ThirdParty.PinLayout,
		.ThirdParty.RxCocoa,
		.ThirdParty.RxSwift,
		.ThirdParty.Kingfisher,
		.DesignSystem,
		.ResourceKit
    ],
    isUserInterface: true
)

