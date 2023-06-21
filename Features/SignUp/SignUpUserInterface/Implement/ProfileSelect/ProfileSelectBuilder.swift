//
//  ProfileSelectBuilder.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//
import SignUpUserInterface

import RIBs

final class ProfileSelectComponent: Component<ProfileSelectDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

final class ProfileSelectBuilder: Builder<ProfileSelectDependency>, ProfileSelectBuildable {

    override init(dependency: ProfileSelectDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ProfileSelectListener) -> ViewableRouting {
        let component = ProfileSelectComponent(dependency: dependency)
        let viewController = ProfileSelectViewController()
        let interactor = ProfileSelectInteractor(presenter: viewController)
        interactor.listener = listener
        return ProfileSelectRouter(interactor: interactor, viewController: viewController)
    }
}
