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

import RIBs

import MOITWebImpl
import MOITWeb

final class LoggedOutComponent: Component<LoggedOutDependency>,
								LoggedOutInteractorDependency,
SignUpDependency,
                                MOITWebDependency {
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { dependency.fetchRandomNumberUseCase }
    
    var signUpUseCase: SignUpUseCase { dependency.signUpUseCase }
    
    var profileSelectBuildable: ProfileSelectBuildable { dependency.profileSelectBuildable }
    
	var saveTokenUseCase: SaveTokenUseCase { dependency.saveTokenUseCase }
}

// MARK: - Builder

public final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override public init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

	public func build(withListener listener: LoggedOutListener) -> ViewableRouting {
        let component = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(
							presenter: viewController,
							dependency: component
						)
        interactor.listener = listener
		
        let signInWebBuilder = MOITWebBuilder(dependency: component)
        let signUpBuilder = SignUpBuilder(dependency: component)
        return LoggedOutRouter(
			interactor: interactor,
			viewController: viewController,
			signInWebBuildable: signInWebBuilder,
			signUpBuildable: signUpBuilder
		)
    }
}
