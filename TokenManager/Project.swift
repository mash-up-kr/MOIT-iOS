//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최혜린 on 2023/07/17.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
	name: "TokenManager",
	platform: .iOS,
	iOSTargetVersion: "16.0.0",
	interfaceDependencies: [
	],
	implementDependencies: [
		.Core.CSLogger
	]
)
