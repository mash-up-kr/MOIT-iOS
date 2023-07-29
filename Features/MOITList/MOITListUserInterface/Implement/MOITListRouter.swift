//
//  MOITListRouter.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITListUserInterface

import RIBs
import MOITWeb

protocol MOITListInteractable: Interactable,
                               MOITWebListener {
    var router: MOITListRouting? { get set }
    var listener: MOITListListener? { get set }
}

protocol MOITListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITListRouter: ViewableRouter<MOITListInteractable, MOITListViewControllable>,
                            MOITListRouting {
    
    init(
        interactor: MOITListInteractable,
        viewController: MOITListViewControllable,
        moitWebBuilder: MOITWebBuildable
    ) {
        self.moitWebBuilder = moitWebBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private let moitWebBuilder: MOITWebBuildable
    private var moitWebRouter: ViewableRouting?
    
    func attachRegisterMOIT() {
        guard moitWebRouter == nil else { return }
        let router = moitWebBuilder.build(
            withListener: interactor,
            domain: .frontend,
            path: .register
        )
        self.moitWebRouter = router
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    func detaachRegisterMOIT(withPop: Bool) {
        guard let moitWebRouter else { return }
        self.moitWebRouter = nil
        detachChild(moitWebRouter)
        if withPop {
            viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
    }
}
