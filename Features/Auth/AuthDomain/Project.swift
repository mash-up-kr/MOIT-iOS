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

let project = Project.invertedDualTargetProject(
    name: "AuthDomain",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.ThirdParty.RxSwift,
		.Feature.Auth.Data.Interface
    ],
    implementDependencies: [
		.TokenManager.Interface
    ]
)

