//
//  SignUpBuilder.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import AuthUserInterface
import AuthDomain

import RIBs

public final class SignUpComponent: Component<SignUpDependency>,
                                    SignUpInteractorDependency,
                                    ProfileSelectDependency {
    
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { dependency.fetchRandomNumberUseCase }
    var signUpUseCase: SignUpUseCase { dependency.signUpUseCase }
    var saveTokenUseCase: SaveTokenUseCase { dependency.saveTokenUseCase }
    
    let signInResponse: MOITSignInResponse
    
    init(
        dependency: SignUpDependency,
        signInResponse: MOITSignInResponse
    ) {
        self.signInResponse = signInResponse
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

public final class SignUpBuilder: Builder<SignUpDependency>,
                                  SignUpBuildable {
    
    public override init(dependency: SignUpDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(
        withListener listener: SignUpListener,
        signInResponse: MOITSignInResponse
    ) -> ViewableRouting {
        let component = SignUpComponent(
            dependency: dependency,
            signInResponse: signInResponse
        )
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        let profileSelectBuilder = ProfileSelectBuilder(dependency: component)
        
        return SignUpRouter(
            interactor: interactor,
            viewController: viewController,
            profileSelectBuildable: profileSelectBuilder
        )
    }
}
