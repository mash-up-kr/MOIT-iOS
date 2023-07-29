//
//  MOITShareAppDelegate.swift
//
//  MOITShare
//
//  Created by 송서영
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITShare",
    interfaceDependencies: [
        .ThirdParty.RIBs,
    ],
    implementDependencies: [
        .ThirdParty.RIBs,
        .ThirdParty.PinLayout,
        .ThirdParty.FlexLayout,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxSwift,
        .ThirdParty.RxGesture,
        .ResourceKit,
        .DesignSystem,
        .Feature.MOITShare.Domain.Implement
    ],
    isUserInterface: true
)
