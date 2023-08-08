//
//  MOITSettingRouter.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITSetting
import MOITWeb

protocol MOITSettingInteractable: Interactable,
                                  MOITWebListener {
    var router: MOITSettingRouting? { get set }
    var listener: MOITSettingListener? { get set }
}

protocol MOITSettingViewControllable: ViewControllable {
}

final class MOITSettingRouter: ViewableRouter<MOITSettingInteractable, MOITSettingViewControllable>,
                               MOITSettingRouting {
    
    init(
        interactor: MOITSettingInteractable,
        viewController: MOITSettingViewControllable,
        moitWebBuilder: MOITWebBuildable
    ) {
        self.moitWebBuilder = moitWebBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    private let moitWebBuilder: MOITWebBuildable
    private var moitWebRouter: ViewableRouting?
    func routeToWeb(path: MOITWebPath) {
        guard moitWebRouter == nil else { return }
        let (router, _) = moitWebBuilder.build(
            withListener: interactor,
            domain: .setting,
            path: path
        )
        moitWebRouter = router
        attachChild(router)
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    func detachWeb(withPop: Bool) {
        guard let moitWebRouter else { return }
        self.moitWebRouter = nil
        detachChild(moitWebRouter)
        if withPop {
            viewController.popViewController(animated: true)
        }
    }
}
