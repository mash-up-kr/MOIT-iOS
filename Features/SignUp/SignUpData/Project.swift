//
//  SignUpAppDelegate.swift
//
//  SignUp
//
//  Created by kimchansoo
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProject(
    name: "SignUpData",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
		.ThirdParty.RxSwift
    ],
    implementDependencies: [
    ]
)

