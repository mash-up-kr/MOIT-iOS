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
    }
    
    public struct Core {
        
    }
    
    public struct MOITNetwork {}
    
    public struct ResourceKit {}

    public struct ThirdParty {}
}

public extension TargetDependency.Core {
    static let folderName = "Core"
    static func project(name: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(target: "\(name)\(postfix)",
                        path: .relativeToRoot("\(folderName)"))
    }
    
//    static let RIBsUtil = project(name: "RIBsUtil", isInterface: true)
}

public extension TargetDependency.ResourceKit {
    static let folderName = "ResourceKit"
    static func project(name: String) -> TargetDependency {
        return .project(target: "\(name)",
                        path: .relativeToRoot("\(folderName)"))
    }

    static let Implement = project(name: "ResourceKit")
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
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
}

// MARK: - Scripts
public extension TargetScript {
    static let swiftLintScript = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"),
        name: "SwiftLint"
    )
}
