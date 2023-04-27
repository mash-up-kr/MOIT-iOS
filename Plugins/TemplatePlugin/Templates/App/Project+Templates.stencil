import ProjectDescription

extension Project {
    private static let organizationName = "chansoo.io"
    
    public static func app(name: String,
                           platform: Platform,
                           iOSTargetVersion: String,
                           infoPlist: String,
                           dependencies: [TargetDependency] = []) -> Project {
        let targets = makeAppTargets(name: name,
                                     platform: platform,
                                     iOSTargetVersion: iOSTargetVersion,
                                     infoPlist: infoPlist,
                                     dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    public static func frameworkWithDemoApp(name: String,
                                            platform: Platform,
                                            iOSTargetVersion: String,
                                            infoPlist: [String: InfoPlist.Value] = [:],
                                            dependencies: [TargetDependency] = []) -> Project {
        var targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
        targets.append(contentsOf: makeAppTargets(name: "\(name)DemoApp",
                                                  platform: platform,
                                                  iOSTargetVersion: iOSTargetVersion,
                                                  infoPlist: infoPlist,
                                                  dependencies: [.target(name: name)]))
        
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    public static func framework(name: String,
                                 platform: Platform,
                                 iOSTargetVersion: String,
                                 dependencies: [TargetDependency] = [],
                                 infoPlist: [String:InfoPlist.Value] = [:]
    ) -> Project {
        let targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           infoPlist: infoPlist,
                                           dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
        
    /// 현재 경로 내부의 Implement, Interface 두개의 디렉토리에 각각 Target을 가지는 Project를 만듭니다.
    /// interface와 implement에 필요한 dependency를 각각 주입해줍니다.
    /// implement는 자동으로 interface에 대한 종속성을 가지고 있습니다.
    public static func invertedDualTargetProject(
        name: String,
        platform: Platform,
        iOSTargetVersion: String,
        interfaceDependencies: [TargetDependency] = [],
        implementDependencies: [TargetDependency] = [],
        demoApp: Bool = false,
        infoPlist: InfoPlist = .default
    ) -> Project {

        let interfaceTarget = makeInterfaceDynamicFrameworkTarget(
            name: name,
            platform: platform,
            iOSTargetVersion: iOSTargetVersion,
            dependencies: interfaceDependencies
        )
        
        let implementTarget = makeImplementStaticLibraryTarget(
            name: name,
            platform: platform,
            iOSTargetVersion: iOSTargetVersion,
            dependencies: implementDependencies + [.target(name: name)]
        )
        
        let testTarget = Target(
             name: "\(name)Tests",
             platform: platform,
             product: .unitTests,
             bundleId: "team.io.\(name)Tests",
             deploymentTarget: .iOS(
                 targetVersion: iOSTargetVersion,
                 devices: [.iphone]
             ),
             infoPlist: .default,
             sources: ["./Tests/**"],
             dependencies: [
                 .target(name: name),
                 .target(name: name + "Impl"),
                 
             ]
         )

        return Project(name: name,
                       organizationName: organizationName,
                       targets: [interfaceTarget, implementTarget, testTarget])
    }
    
    /// 현재 경로 내부의 Implement, Interface, DemoApp 세개의 디렉토리에 각각 Target을 가지는 Project를 만듭니다.
    /// interface와 implement에 필요한 dependency를 각각 주입해줍니다.
    /// implement는 자동으로 interface에 대한 종속성을 가지고 있습니다.
    ///
    public static func invertedDualTargetProjectWithDemoApp(
        name: String,
        platform: Platform,
        iOSTargetVersion: String,
        interfaceDependencies: [TargetDependency] = [],
        implementDependencies: [TargetDependency] = [],
        demoApp: Bool = false,
        infoPlist: InfoPlist = .default
    ) -> Project {

        let interfaceTarget = makeInterfaceDynamicFrameworkTarget(
            name: name,
            platform: platform,
            iOSTargetVersion: iOSTargetVersion,
            dependencies: interfaceDependencies
        )
        
        let implementTarget = makeImplementStaticLibraryTarget(
            name: name,
            platform: platform,
            iOSTargetVersion: iOSTargetVersion,
            dependencies: implementDependencies + [.target(name: name)]
        )
        
        let demoApp = Target(
            name: "\(name)DemoApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.chansoo.\(name)Demoapp",
            deploymentTarget: .iOS(
              targetVersion: iOSTargetVersion,
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
            dependencies: implementDependencies + [.target(name: name)]
        )

        return Project(name: name,
                       organizationName: organizationName,
                       targets: [interfaceTarget, implementTarget, demoApp])
    }

    public static func makeTarget(
        name: String,
        dependencies: [TargetDependency],
        iOSTargetVersion: String = "15.0.0"
    ) -> Target {
        return Target(name: name,
               platform: .iOS,
               product: .framework,
               bundleId: "team.io.\(name)",
               deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
               infoPlist: .default,
               sources: ["./\(name)/**"],
    //           resources: ["Resources/**"],
               dependencies: dependencies)
    }

}

private extension Project {
    
    static func makeImplementStaticLibraryTarget(
        name: String,
        platform: Platform,
        iOSTargetVersion: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return Target(name: "\(name)Impl",
                      platform: platform,
                      product: .staticLibrary,
                      bundleId: "team.io.\(name)",
                      deploymentTarget: .iOS(
                        targetVersion: iOSTargetVersion,
                        devices: [.iphone]
                      ),
                      infoPlist: .default,
                      sources: ["./Implement/**"],
//                      sources: ["\(name)/Sources/Implement/**"],
//                      resources: ["Resources/**"],
                      dependencies: dependencies)
    }
    
    static func makeInterfaceDynamicFrameworkTarget(
        name: String,
        platform: Platform,
        iOSTargetVersion: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        return Target(name: name,
                      platform: platform,
                      product: .framework,
                      bundleId: "team.io.\(name)",
                      deploymentTarget: .iOS(
                        targetVersion: iOSTargetVersion,
                        devices: [.iphone]
                      ),
                      infoPlist: .default,
                      sources: ["./Interface/**"],
                      //                             resources: ["Resources/**"],
                      dependencies: dependencies)
    }

    
    static func makeFrameworkTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: [String:InfoPlist.Value] = [:] ,dependencies: [TargetDependency] = []) -> [Target] {
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "team.io.\(name)",
                             deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                             infoPlist: .extendingDefault(with: infoPlist),
//                             infoPlist: .default,
                             sources: ["Sources/**"],
                             resources: ["Resources/**"],
                             dependencies: dependencies)
//        let tests = Target(name: "\(name)Tests",
//                           platform: platform,
//                           product: .unitTests,
//                           bundleId: "team.io.\(name)Tests",
//                           infoPlist: .default,
//                           sources: ["Tests/**"],
//                           resources: [],
//                           dependencies: [
//                            .target(name: name)
//                           ])
        return [sources]
    }
    
    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: [String: InfoPlist.Value] = [:], dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "team.io.\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )
        
//        let testTarget = Target(
//            name: "\(name)Tests",
//            platform: platform,
//            product: .unitTests,
//            bundleId: "team.io.Tests",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            dependencies: [
//                .target(name: "\(name)"),
//            ])
        return [mainTarget]
    }
    
    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: String, dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "team.io.\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: InfoPlist(stringLiteral: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )
        return [mainTarget]
    }
}
