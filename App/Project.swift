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
    settings: .settings(
        base: [
            "GCC_PREPROCESSOR_DEFINITIONS[arch=*]": "FLEXLAYOUT_SWIFT_PACKAGE=1",
        ],
        configurations: [.debug(name: .debug)]
    ),
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
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": false,
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
            
            entitlements: "../MOIT.entitlements",
            dependencies: [
                .ThirdParty.RIBs,
            ],
            settings: .settings(configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("Config/Debug.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("Config/Release.xcconfig")),
            ])
        )
    ]
)
