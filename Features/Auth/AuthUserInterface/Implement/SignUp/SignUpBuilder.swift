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

public final class SignUpComponent: Component<SignUpDependency>, SignUpInteractorDependency {
    
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { dependency.fetchRandomNumberUseCase }
    var postJoinInfoUseCase: PostJoinInfoUseCase { dependency.postJoinInfoUseCase }
    var profileSelectBuildable: ProfileSelectBuildable { dependency.profileSelectBuildable }
}

// MARK: - Builder

public final class SignUpBuilder: Builder<SignUpDependency>, SignUpBuildable {
    
    public override init(dependency: SignUpDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: SignUpListener) -> ViewableRouting {
        let component = SignUpComponent(dependency: dependency)
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return SignUpRouter(
            interactor: interactor,
            viewController: viewController,
            profileSelectBuildable: dependency.profileSelectBuildable
        )
    }
}
