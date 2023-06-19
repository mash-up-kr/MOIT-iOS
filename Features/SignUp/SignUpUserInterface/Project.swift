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

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "SignUpUserInterface",
    platform: .iOS,
    iOSTargetVersion: "15.0.0",
    interfaceDependencies: [
        .ThirdParty.RIBs,
        .ThirdParty.RxSwift,
    ],
    implementDependencies: [
        .ThirdParty.RxGesture,
        .ThirdParty.RxSwift,
        .ThirdParty.RxCocoa,
        .ThirdParty.RIBs,

        .ResourceKit,
        .DesignSystem,
        .Core.Utils,
        
        .Feature.SignUp.Domain.Interface,
        .Feature.SignUp.Data.Interface,
    ],
    isUserInterface: true
)
