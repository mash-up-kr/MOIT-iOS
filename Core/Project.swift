//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김찬수 on 2023/06/02.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project(
    name: "Core",
    targets: [
        Project.makeTarget(
            name: "CSLogger",
            dependencies: []
        ),
        Project.makeTarget(
            name: "Utils",
            dependencies: [
                .DesignSystem,
                .ResourceKit,
                
                .ThirdParty.PinLayout,
                .ThirdParty.FlexLayout,
            ]
        ),
    Project.makeTarget(
        name: "MOITFoundation",
        dependencies: []
    ),
    ]
)
