//
//  RootRouter.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import MOITWeb
import MOITWebImpl

protocol RootInteractable: Interactable,
                           MOITWebListener {
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ViewControllable {
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
                        RootRouting {
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        moitWebBuilder: MOITWebBuildable
    ) {
        self.moitWebBuilder = moitWebBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    private let moitWebBuilder: MOITWebBuildable
    private var moitWebRouter: ViewableRouting?
    
    func routeToMoitWeb(path: MOITWebPath) {
        guard self.moitWebRouter == nil else { return }
        let router = moitWebBuilder.build(
            withListener: self.interactor,
            domain: .frontend,
            path: path
        )
        
        self.viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
        self.moitWebRouter = router
        self.attachChild(router)
    }
    
    func detachWeb(withPop: Bool) {
        guard let moitWebRouter else { return }
        if withPop {
            self.viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
        
        self.moitWebRouter = nil
        self.detachChild(moitWebRouter)
    }
}
