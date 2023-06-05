//
//  ShareBuilder.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol ShareDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ShareComponent: Component<ShareDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ShareBuildable: Buildable {
    func build(withListener listener: ShareListener) -> ShareRouting
}

final class ShareBuilder: Builder<ShareDependency>, ShareBuildable {

    override init(dependency: ShareDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ShareListener) -> ShareRouting {
        let component = ShareComponent(dependency: dependency)
        let viewController = ShareViewController(contentView: MOITShareView(invitationCode: "전ㅈr군단"))
        let interactor = ShareInteractor(presenter: viewController)
        interactor.listener = listener
        return ShareRouter(interactor: interactor, viewController: viewController)
    }
}
