//
//  MOITListAppDelegate.swift
//
//  MOITList
//
//  Created by kimchansoo
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.invertedDualTargetProjectWithDemoApp(
    name: "MOITListUserInterface",
    platform: .iOS,
    iOSTargetVersion: "16.0.0",
    interfaceDependencies: [
        .ThirdParty.RxSwift,
        .ThirdParty.RIBs,
        .Feature.MOITDetail.Domain.Interface,
    ],
    implementDependencies: [
        .ThirdParty.RxSwift,
        .ThirdParty.RxCocoa,
        .ThirdParty.RxRelay,
        .ThirdParty.RIBs,
        .ThirdParty.PinLayout,
        .ThirdParty.FlexLayout,
        .ThirdParty.RxGesture,
        
        .ResourceKit,
        .DesignSystem,
        .Core.Utils,
        
        .Feature.MOITList.Domain.Interface,
        .Feature.MOITDetail.Implement,
        .Feature.MOITDetail.Interface,
        .MOITNetwork.Interface,
        
        .Feature.MOITParticipate.UserInterface.Implement,
        .Feature.MOITParticipate.UserInterface.Interface
    ],
    demoAppDependencies: [
        .Feature.MOITList.Domain.Implement,
        .Feature.MOITList.Data.Implement,
        
        .MOITNetwork.Implement,
        .MOITNetwork.Interface,
    ],
    isUserInterface: true
)

