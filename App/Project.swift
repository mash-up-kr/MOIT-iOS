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
                        "CFBundleIconName": "AppIcon",
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
                        "NSPhotoLibraryUsageDescription": "벌금 인증 이미지 업로드를 위해 앨범 접근 권한이 필요합니다.",
//                        "CFBundleURLTypes" : ["App-prefs"],
                        "UIBackgroundModes": [
                            "fetch",
                            "remote-notification",
                        ]
                    ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            
            entitlements: "../MOIT.entitlements",
            scripts: [.swiftLintScript],
            dependencies: [
                .ThirdParty.RIBs,
                .ThirdParty.SkeletonView,
                .ThirdParty.RxCocoa,
                .ThirdParty.RxSwift,
                .ThirdParty.RxGesture,
                
                .Feature.MOITWeb.Implement,
                
                
                .TokenManager.Implement,
                .TokenManager.Interface,
                
                .MOITNetwork.Interface,
                .MOITNetwork.Implement,
                
                .Feature.MOITList.Domain.Interface,
                .Feature.MOITList.Domain.Implement,
                .Feature.MOITList.Data.Interface,
                .Feature.MOITList.Data.Implement,
                .Feature.MOITList.UserInterface.Interface,
                .Feature.MOITList.UserInterface.Implement,
                
                .Feature.Auth.Domain.Interface,
                .Feature.Auth.Domain.Implement,
                .Feature.Auth.Data.Interface,
                .Feature.Auth.Data.Implement,
                .Feature.Auth.UserInterface.Interface,
                .Feature.Auth.UserInterface.Implement,
                .ThirdParty.FirebaseMessaging,
				
				.Feature.MOITAlarm.Data.Interface,
				.Feature.MOITAlarm.Data.Implement,
				.Feature.MOITAlarm.Domain.Interface,
				.Feature.MOITAlarm.Domain.Implement,
            ],
            
            settings: .settings(configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("Config/Debug.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("Config/Release.xcconfig")),
            ])
        )
    ]
)
