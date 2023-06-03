//
//  MainAppDelegate.swift
//
//  Main
//
//  Created by kimchansoo
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project(
    name: "DesignSystem",
    organizationName: "chansoo.MOIT",
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: .relativeToRoot("Config/Debug.xcconfig")),
        .release(name: "Release", xcconfig: .relativeToRoot("Config/Release.xcconfig")),
    ]),
    targets: [
        Target(name: "DesignSystem",
               platform: .iOS,
               product: .framework,
               bundleId: "team.io.DesignSystem",
               deploymentTarget: .iOS(
                targetVersion: "15.0.0",
                devices: [.iphone]
               ),
               infoPlist: .default,
               sources: ["Sources/**"],
               scripts: [.swiftLintScript],
               dependencies: [
                .ThirdParty.PinLayout,
                .ThirdParty.FlexLayout,
                .ResourceKit,
                .ThirdParty.RxCocoa,
                .ThirdParty.RxSwift,
                .ThirdParty.RxGesture,
               ]),
        Target(
            name: "DesignSystemDemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.chansoo.DesignSystemDemoApp",
            deploymentTarget: .iOS(
                targetVersion: "15.0.0",
                devices: [.iphone]
            ),
            infoPlist: InfoPlist.extendingDefault(
                with:
                    [
                        "CFBundleDevelopmentRegion": "ko_KR",
                        "CFBundleShortVersionString": "1.0",
                        "CFBundleVersion": "1",
                        "UILaunchStoryboardName": "LaunchScreen"
                    ]
            ),
            sources: ["./DemoApp/Sources/**"],
            resources: ["./DemoApp/Resources/**"],
            scripts: [.swiftLintScript],
            dependencies:
                [
                    .target(name: "DesignSystem"),
                    .ThirdParty.FlexLayout,
                    .ThirdParty.PinLayout,
                    .ThirdParty.RxCocoa,
                    .ThirdParty.RxSwift,
                    .ThirdParty.RxGesture,
                ]
        )
        
    ]
)
