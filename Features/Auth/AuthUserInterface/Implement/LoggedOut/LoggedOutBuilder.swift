//
//  LoggedOutBuilder.swift
//  SignInUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthUserInterface
import AuthDomain
import MOITWeb

import RIBs
import MOITWebImpl

import MOITWebImpl
import MOITWeb

final class LoggedOutComponent: Component<LoggedOutDependency>,
								LoggedOutInteractorDependency,
                                MOITWebDependency,
                                SignUpDependency
{
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { dependency.fetchRandomNumberUseCase }
    var signUpUseCase: SignUpUseCase { dependency.signUpUseCase }
    #warning("얘 지워")
    var profileSelectBuildable: ProfileSelectBuildable { dependency.profileSelectBuildable }
	var fetchUserInfoUseCase: FetchUserInfoUseCase { dependency.fetchUserInfoUseCase }
	var saveUserIDUseCase: SaveUserIDUseCase { dependency.saveUserIDUseCase }
	var saveTokenUseCase: SaveTokenUseCase { dependency.saveTokenUseCase }
}

// MARK: - Builder

public final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override public init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }
	
	deinit { debugPrint("\(self) deinit") }

	public func build(withListener listener: LoggedOutListener) -> ViewableRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(
							presenter: viewController,
							dependency: component
						)
      
        interactor.listener = listener
		
        let moitWebBuilder = MOITWebBuilder(dependency: component)
        let signUpBuilder = SignUpBuilder(dependency: component)
        return LoggedOutRouter(
			interactor: interactor,
			viewController: viewController,
			signInWebBuildable: moitWebBuilder,
			signUpBuildable: signUpBuilder
		)
    }
}
