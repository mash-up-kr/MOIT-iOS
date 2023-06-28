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

public final class ProfileSelectBuilder: Builder<ProfileSelectDependency>, ProfileSelectBuildable {

    public override init(dependency: ProfileSelectDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: ProfileSelectListener, currentImageIndex: Int?) -> ViewableRouting {
        let component = ProfileSelectComponent(dependency: dependency)
        let viewController = ProfileSelectViewContoller()
        let interactor = ProfileSelectInteractor(presenter: viewController, currentImageIndex: currentImageIndex)
        interactor.listener = listener
        return ProfileSelectRouter(interactor: interactor, viewController: viewController)
    }
}
