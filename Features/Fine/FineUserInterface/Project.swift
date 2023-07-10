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
		.ThirdParty.RIBs
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
    isUserInterface: true
)

