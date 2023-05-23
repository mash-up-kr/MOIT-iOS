//
//  AppProject.swift
//
//  MOIT
//
//  Created by 김찬수
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project(
    name: "App",
    targets: [
        Target(
            name: "App",
            platform: .iOS,
            product: .app,
            bundleId: "com.chansoo.MOIT",
            infoPlist: InfoPlist.extendingDefault(
                with:
                    [
                        "CFBundleDevelopmentRegion": "ko_KR",
                        "CFBundleShortVersionString": "1.0",
                        "CFBundleVersion": "1",
                        "UILaunchStoryboardName": "LaunchScreen",
                        "NSAppTransportSecurity": [
                            "NSAllowsArbitraryLoads": true
                        ],
                        "UIBackgroundModes": [
                            "fetch",
                            "remote-notification",
                            "remove-notification"
                        ],
                    ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: "MOIT.entitlements"
            dependencies: [
                .ThirdParty.RIBs,
            ]
        )
    ]
)
