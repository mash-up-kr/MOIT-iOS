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
import MOITDetail

protocol MOITListInteractable: Interactable,
                               MOITWebListener,
                               MOITDetailListener {
    var router: MOITListRouting? { get set }
    var listener: MOITListListener? { get set }
}

protocol MOITListViewControllable: ViewControllable {
}

final class MOITListRouter: ViewableRouter<MOITListInteractable, MOITListViewControllable>,
                            MOITListRouting {
    
    init(
        interactor: MOITListInteractable,
        viewController: MOITListViewControllable,
        moitWebBuilder: MOITWebBuildable,
        moitDetailBuilder: MOITDetailBuildable
    ) {
        self.moitWebBuilder = moitWebBuilder
        self.moitDetailBuilder = moitDetailBuilder
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
    func detachRegisterMOIT(withPop: Bool) {
        guard let moitWebRouter else { return }
        self.moitWebRouter = nil
        detachChild(moitWebRouter)
        if withPop {
            viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
    }
    
    private let moitDetailBuilder: MOITDetailBuildable
    private var moitDetailRouter: ViewableRouting?
    
    func attachMOITDetail(id: String) {
        guard moitDetailRouter == nil else { return }
        let router = moitDetailBuilder.build(withListener: interactor, moitID: id)
        self.moitDetailRouter = router
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    func detachMOITDetail() {
        guard let moitDetailRouter else { return }
        self.moitDetailRouter = nil
        detachChild(moitDetailRouter)
        viewController.uiviewController.navigationController?.popViewController(animated: true)
    }
}
