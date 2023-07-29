//
//  ShareBuilder.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITShare
import MOITShareDomain
import MOITShareDomainImpl

final class ShareComponent: Component<ShareDependency> {
}

// MARK: - Builder

public final class ShareBuilder: Builder<ShareDependency>,
                            ShareBuildable {

    public override init(dependency: ShareDependency) {
        super.init(dependency: dependency)
    }

    public func build(
        withListener listener: ShareListener,
        code: String
    ) -> ViewableRouting {
        let component = ShareComponent(dependency: dependency)
        let viewController = ShareViewController(contentView: MOITShareView(invitationCode: code))
        
        let interactor = ShareInteractor(
            presenter: viewController,
            shareUsecase: MOITShareUsecaseImpl(),
            invitationCode: code
        )
        interactor.listener = listener
        return ShareRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
