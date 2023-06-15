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
    ],
    implementDependencies: [
    ],
    isUserInterface: true
)

