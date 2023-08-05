//
//  MOITWebRouter.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import MOITWeb

import RIBs
import MOITShare

protocol MOITWebInteractable: Interactable,
                              ShareListener {
    var router: MOITWebRouting? { get set }
    var listener: MOITWebListener? { get set }
}

protocol MOITWebViewControllable: ViewControllable {
}

final class MOITWebRouter: ViewableRouter<MOITWebInteractable, MOITWebViewControllable>,
						   MOITWebRouting {
	
    init(
        interactor: MOITWebInteractable,
        viewController: MOITWebViewControllable,
        shareBuilder: ShareBuildable
    ) {
        self.shareBuilder = shareBuilder
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    private let shareBuilder: ShareBuildable
    private var shareRouter: ViewableRouting?
    
    func routeToShare(invitationCode: String) {
        guard shareRouter == nil else { return }
        let router = shareBuilder.build(
            withListener: interactor,
            code: invitationCode
        )
        self.shareRouter = router
        attachChild(router)
        viewController.uiviewController.present(
            router.viewControllable.uiviewController,
            animated: true
        )
    }
    
    func detachShare() {
        guard let shareRouter else { return }
        self.shareRouter = nil
        detachChild(shareRouter)
        viewController.uiviewController.dismiss(animated: true)
    }
}
