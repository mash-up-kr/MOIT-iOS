import Foundation
import ProjectDescription

// MARK: Project
extension TargetDependency {
    public struct Feature {
        
        public struct Home {
            public struct Data {}
            public struct Domain {}
            public struct UserInterface {}
        }
        public struct MOITShare {
            public struct Data {}
            public struct Domain {}
            public struct UserInterface {}
        }
        public struct MOITDetail {
            public struct Data {}
            public struct Domain {}
        }
    }
    
    public struct Core {
        
    }
    
    public struct MOITNetwork {}
    
    public static let ResourceKit = TargetDependency.project(
        target: "ResourceKit",
        path: .relativeToRoot("ResourceKit")
    )
    
    public static let DesignSystem = TargetDependency.project(
        target: "DesignSystem",
        path: .relativeToRoot("DesignSystem")
    )

    public struct ThirdParty {}
}

public extension TargetDependency.Core {
    static let folderName = "Core"
    static func project(name: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(target: "\(name)\(postfix)",
                        path: .relativeToRoot("\(folderName)"))
    }
    
    static let CSLogger = project(name: "CSLogger", isInterface: true)
}

// MARK: - Features/Home
public extension TargetDependency.Feature.Home {
    static let folderName = "Home"
    static func project(name: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(target: "\(folderName)\(name)\(postfix)",
                        path: .relativeToRoot("Features/\(folderName)/\(folderName)\(name)"))
    }}

public extension TargetDependency.Feature.Home.UserInterface {
    static let Interface = TargetDependency.Feature.Home.project(name: "UserInterface", isInterface: true)
    static let Implement = TargetDependency.Feature.Home.project(name: "UserInterface", isInterface: false)
}

public extension TargetDependency.Feature.Home.Domain {
    static let Interface = TargetDependency.Feature.Home.project(name: "Domain", isInterface: true)
    static let Implement = TargetDependency.Feature.Home.project(name: "Domain", isInterface: false)
}

public extension TargetDependency.Feature.Home.Data {
    static let Interface = TargetDependency.Feature.Home.project(name: "Data", isInterface: true)
    static let Implement = TargetDependency.Feature.Home.project(name: "Data", isInterface: false)
}


// MARK: - Network
public extension TargetDependency.MOITNetwork {
    static let folderName = "MOITNetwork"
    static func project(name: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(
            target: "\(name)\(postfix)",
            path: .relativeToRoot("MOITNetwork")
        )
    }
    
    static let Interface = project(name: "MOITNetwork", isInterface: true)
    static let Implement = project(name: "MOITNetwork", isInterface: false)
}

// MARK: - ThirdParty

public extension TargetDependency.ThirdParty {

    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let RxRelay = TargetDependency.external(name: "RxRelay")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RIBs = TargetDependency.external(name: "RIBs")
    static let RxGesture = TargetDependency.external(name: "RxGesture")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let Quick = TargetDependency.external(name: "Quick")
    static let Nimble = TargetDependency.external(name: "Nimble")
    static let SkeletonView = TargetDependency.external(name: "SkeletonView")
}

public extension TargetDependency.ThirdParty {
    private static func framework(name: String) -> TargetDependency {
        .xcframework(path: .relativeToRoot("Tuist/Dependencies/Carthage/Build/\(name).xcframework"))
    }
    
    static let FlexLayout = framework(name: "FlexLayout")
    static let PinLayout = framework(name: "PinLayout")
}


// MARK: - Scripts
public extension TargetScript {
    static let swiftLintScript = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
    )
}


// MARK: - MOITWeb
extension TargetDependency.Feature {
    public struct MOITWeb {
    }
}

extension TargetDependency.Feature.MOITWeb {
    static func project(isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(target: "MOITWeb\(postfix)",
                        path: .relativeToRoot("Features/MOITWeb"))
    }
    
    public static let Interface = Self.project(isInterface: true)
    public static let Implement = Self.project(isInterface: false)
}

// MARK: - MOITDetail

extension TargetDependency.Feature.MOITDetail {
    static func project(moduleName: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(
            target: "\(moduleName)\(postfix)",
            path: .relativeToRoot("Features/MOITDetail/\(moduleName)")
        )
    }
    
    public static let Interface: TargetDependency = .project(
        target: "MOITDetail",
        path: .relativeToRoot("Features/MOITDetail")
    )
    public static let Implement: TargetDependency = .project(
        target: "MOITDetailImpl",
        path: .relativeToRoot("Features/MOITDetail")
    )
}

public extension TargetDependency.Feature.MOITDetail.Data {
    static let Interface = TargetDependency.Feature.MOITDetail.project(moduleName: "MOITDetailData", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITDetail.project(moduleName: "MOITDetailData", isInterface: false)
}

public extension TargetDependency.Feature.MOITDetail.Domain {
    static let Interface = TargetDependency.Feature.MOITDetail.project(moduleName: "MOITDetailDomain", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITDetail.project(moduleName: "MOITDetailDomain", isInterface: false)
}
