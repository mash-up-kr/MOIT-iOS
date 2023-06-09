//
//  MOITDetailBuilder.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetail

public protocol MOITDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MOITDetailComponent: Component<MOITDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder



final class MOITDetailBuilder: Builder<MOITDetailDependency>, MOITDetailBuildable {

    override init(dependency: MOITDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MOITDetailListener) -> ViewableRouting {
        let component = MOITDetailComponent(dependency: dependency)
        let viewController = MOITDetailViewController()
        let interactor = MOITDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return MOITDetailRouter(interactor: interactor, viewController: viewController)
    }
}
