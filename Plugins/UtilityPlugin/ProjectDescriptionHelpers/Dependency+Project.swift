import Foundation
import ProjectDescription

// MARK: Project
extension TargetDependency {
	public struct Feature {
		
		public struct MOITList {
			public struct Data {}
			public struct Domain {}
			public struct UserInterface {}
		}
		
		public struct Auth {
			public struct Data {}
			public struct Domain {}
			public struct UserInterface {}
		}
		
		public struct MOITShare {
            public struct Domain {}
		}
		
		public struct MOITParticipate {
			public struct Data {}
			public struct Domain {}
			public struct UserInterface {}
		}
		
		public struct MOITDetail {
			public struct Data {}
			public struct Domain {}
		}
        
        public struct MOITSetting {}

        public struct MOITAlarm {
            public struct Data {}
            public struct Domain {}
        }
	}

    public struct Core { }
    
    public struct MOITNetwork {}
	
	public struct TokenManager {}
    
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
    static func project(name: String, isInterface: Bool = true) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(target: "\(name)\(postfix)",
                        path: .relativeToRoot("\(folderName)"))
    }
    
    static let CSLogger = project(name: "CSLogger", isInterface: true)
    static let Utils = project(name: "Utils", isInterface: true)
    static let MOITFoundation = project(name: "MOITFoundation")
}

public extension TargetDependency.TokenManager {
	static let folderName = "TokenManager"
	static func project(name: String, isInterface: Bool) -> TargetDependency {
		let postfix: String = isInterface ? "" : "Impl"
		return .project(target: "\(name)\(postfix)",
						path: .relativeToRoot("\(folderName)"))
	}
	
	static let Interface = project(name: "TokenManager", isInterface: true)
	static let Implement = project(name: "TokenManager", isInterface: false)
}

// MARK: - Features/Home
public extension TargetDependency.Feature.MOITList {
    static let folderName = "MOITList"
    static func project(name: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(target: "\(folderName)\(name)\(postfix)",
                        path: .relativeToRoot("Features/\(folderName)/\(folderName)\(name)"))
    }
}

public extension TargetDependency.Feature.MOITList.UserInterface {
    static let Interface = TargetDependency.Feature.MOITList.project(name: "UserInterface", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITList.project(name: "UserInterface", isInterface: false)
}

public extension TargetDependency.Feature.MOITList.Domain {
    static let Interface = TargetDependency.Feature.MOITList.project(name: "Domain", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITList.project(name: "Domain", isInterface: false)
}

public extension TargetDependency.Feature.MOITList.Data {
    static let Interface = TargetDependency.Feature.MOITList.project(name: "Data", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITList.project(name: "Data", isInterface: false)
}

// MARK: - Features/SignIn

public extension TargetDependency.Feature.Auth {
	static let folderName = "Auth"
	static func project(name: String, isInterface: Bool) -> TargetDependency {
		let postfix: String = isInterface ? "" : "Impl"
		return .project(target: "\(folderName)\(name)\(postfix)",
						path: .relativeToRoot("Features/\(folderName)/\(folderName)\(name)"))
	}
}

public extension TargetDependency.Feature.Auth.UserInterface {
	static let Interface = TargetDependency.Feature.Auth.project(name: "UserInterface", isInterface: true)
	static let Implement = TargetDependency.Feature.Auth.project(name: "UserInterface", isInterface: false)
}

public extension TargetDependency.Feature.Auth.Domain {
	static let Interface = TargetDependency.Feature.Auth.project(name: "Domain", isInterface: true)
	static let Implement = TargetDependency.Feature.Auth.project(name: "Domain", isInterface: false)
}

public extension TargetDependency.Feature.Auth.Data {
	static let Interface = TargetDependency.Feature.Auth.project(name: "Data", isInterface: true)
	static let Implement = TargetDependency.Feature.Auth.project(name: "Data", isInterface: false)
}

// MARK: - Features/MOITParticipate
public extension TargetDependency.Feature.MOITParticipate {
	static let folderName = "MOITParticipate"
	static func project(name: String, isInterface: Bool) -> TargetDependency {
		let postfix: String = isInterface ? "" : "Impl"
		return .project(target: "\(folderName)\(name)\(postfix)",
						path: .relativeToRoot("Features/\(folderName)/\(folderName)\(name)"))
	}
}

public extension TargetDependency.Feature.MOITParticipate.UserInterface {
	static let Interface = TargetDependency.Feature.MOITParticipate.project(name: "UserInterface", isInterface: true)
	static let Implement = TargetDependency.Feature.MOITParticipate.project(name: "UserInterface", isInterface: false)
}

public extension TargetDependency.Feature.MOITParticipate.Domain {
	static let Interface = TargetDependency.Feature.MOITParticipate.project(name: "Domain", isInterface: true)
	static let Implement = TargetDependency.Feature.MOITParticipate.project(name: "Domain", isInterface: false)
}

public extension TargetDependency.Feature.MOITParticipate.Data {
	static let Interface = TargetDependency.Feature.MOITParticipate.project(name: "Data", isInterface: true)
	static let Implement = TargetDependency.Feature.MOITParticipate.project(name: "Data", isInterface: false)
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
    static let Collections = TargetDependency.external(name: "Collections")
	static let Toast = TargetDependency.external(name: "Toast")
    static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
    static let Firebase = TargetDependency.external(name: "Firebase")
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
        path: .relativeToRoot("Features/MOITDetail/MOITDetail")
    )
    public static let Implement: TargetDependency = .project(
        target: "MOITDetailImpl",
        path: .relativeToRoot("Features/MOITDetail/MOITDetail")
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

// MARK: - MOITShare
public extension TargetDependency.Feature.MOITShare {
    static let Interface: TargetDependency = .project(target: "MOITShare", path: .relativeToRoot("Features/MOITShare/MOITShare"))
    static let Implement: TargetDependency = .project(target: "MOITShareImpl", path: .relativeToRoot("Features/MOITShare/MOITShare"))
}

public extension TargetDependency.Feature.MOITShare.Domain {
    static func project(isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(
            target: "MOITShareDomain\(postfix)",
            path: .relativeToRoot("Features/MOITShare/MOITShareDomain")
        )
    }
    static let Interface = Self.project(isInterface: true)
    static let Implement = Self.project(isInterface: false)
}

// MARK: - MOITSetting
public extension TargetDependency.Feature.MOITSetting {
    static let Interface: TargetDependency = .project(target: "MOITSetting", path: .relativeToRoot("Features/MOITSetting/MOITSetting"))
    static let Implement: TargetDependency = .project(target: "MOITSettingImpl", path: .relativeToRoot("Features/MOITSetting/MOITSetting"))
}
// MARK: - MOITAlarm

extension TargetDependency.Feature.MOITAlarm {
    static func project(moduleName: String, isInterface: Bool) -> TargetDependency {
        let postfix: String = isInterface ? "" : "Impl"
        return .project(
            target: "\(moduleName)\(postfix)",
            path: .relativeToRoot("Features/MOITAlarm/\(moduleName)")
        )
    }
    
    public static let Interface: TargetDependency = .project(
        target: "MOITAlarm",
        path: .relativeToRoot("Features/MOITAlarm")
    )
    public static let Implement: TargetDependency = .project(
        target: "MOITAlarmImpl",
        path: .relativeToRoot("Features/MOITAlarm")
    )
}

public extension TargetDependency.Feature.MOITAlarm.Data {
    static let Interface = TargetDependency.Feature.MOITAlarm.project(moduleName: "MOITAlarmData", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITAlarm.project(moduleName: "MOITAlarmData", isInterface: false)
}

public extension TargetDependency.Feature.MOITAlarm.Domain {
    static let Interface = TargetDependency.Feature.MOITAlarm.project(moduleName: "MOITAlarmDomain", isInterface: true)
    static let Implement = TargetDependency.Feature.MOITAlarm.project(moduleName: "MOITAlarmDomain", isInterface: false)
}
