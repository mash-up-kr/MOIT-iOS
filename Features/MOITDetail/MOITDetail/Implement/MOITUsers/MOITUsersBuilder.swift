//
//  MOITUsersBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetailDomain

protocol MOITUsersDependency: Dependency {
    var moitUserusecase: MOITUserUsecase { get }
}

final class MOITUsersComponent: Component<MOITUsersDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MOITUsersBuildable: Buildable {
    func build(withListener listener: MOITUsersListener, moitID: String) -> MOITUsersRouting
}

final class MOITUsersBuilder: Builder<MOITUsersDependency>, MOITUsersBuildable {

    override init(dependency: MOITUsersDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MOITUsersListener, moitID: String) -> MOITUsersRouting {
        let component = MOITUsersComponent(dependency: dependency)
        let viewController = MOITUsersViewController()
        let interactor = MOITUsersInteractor(
            presenter: viewController,
            usecase: dependency.moitUserusecase,
            moitID: moitID
        )
        interactor.listener = listener
        return MOITUsersRouter(interactor: interactor, viewController: viewController)
    }
}
