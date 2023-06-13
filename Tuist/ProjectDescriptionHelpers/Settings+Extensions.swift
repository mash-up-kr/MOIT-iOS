//
//  Settings+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by 송서영 on 2023/05/28.
//

import ProjectDescription

extension Settings {
    static var flexLayoutSetting: Settings {
        return .settings(
            base: [
                "GCC_PREPROCESSOR_DEFINITIONS[arch=*]": "FLEXLAYOUT_SWIFT_PACKAGE=1",
            ],
            configurations: [.debug(name: .debug)]
        )
    }
}
