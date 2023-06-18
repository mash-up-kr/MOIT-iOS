//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최혜린 on 2023/05/15.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
	name: "MOITNetwork",
	platform: .iOS,
	iOSTargetVersion: "16.0.0",
	interfaceDependencies: [
		.ThirdParty.RxSwift,
		.ThirdParty.RxCocoa
	],
	implementDependencies: [
		.ThirdParty.RxSwift,
		.ThirdParty.RxCocoa
	]
)
