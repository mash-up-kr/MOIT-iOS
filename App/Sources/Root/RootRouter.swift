//
//  RootRouter.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import MOITWeb
import MOITWebImpl
import AuthUserInterface
import MOITListUserInterface
import UIKit

protocol RootInteractable: Interactable,
                           MOITWebListener,
                           LoggedOutListener,
                           MOITListListener
{
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ViewControllable {
    
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
                        RootRouting {

    // MARK: - Properties
    
    private let moitWebBuilder: MOITWebBuildable
    private var moitWebRouter: ViewableRouting?
    
    private let moitListBuilder: MOITListBuildable
    private var moitListRouter: ViewableRouting?
    
    private let authBuilder: LoggedOutBuildable
    private var authRouter: ViewableRouting?

    // MARK: - Initializers

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        moitWebBuilder: MOITWebBuildable,
        moitListBuilder: MOITListBuildable,
        loggedOutBuilder: LoggedOutBuildable
    ) {
        self.moitWebBuilder = moitWebBuilder
        self.moitListBuilder = moitListBuilder
        self.authBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    // MARK: - Methods
    
    func routeToAuth() {
        if authRouter != nil { return }
        
        let router = authBuilder.build(withListener: interactor)
        
        self.authRouter = router
        attachChild(router)
        let viewCon = router.viewControllable.uiviewController
        viewCon.modalPresentationStyle = .overFullScreen
        self.viewController.uiviewController.present(router.viewControllable.uiviewController, animated: false)
        
    }
    
    func detachAuth() {
        guard let router = authRouter else { return }
        
        authRouter = nil
        detachChild(router)
        router.viewControllable.uiviewController.dismiss(animated: false)
    }
    
    func routeToMOITList() {
        if moitListRouter != nil { return }
        
        let router = moitListBuilder.build(withListener: interactor)
        
        self.viewController.uiviewController.navigationController?.pushViewController(
            router.viewControllable.uiviewController,
            animated: true
        )
        
        self.moitListRouter = router
        attachChild(router)
    }
    
    func detachMOITList() {
        guard let router = moitListRouter else { return }
        
        viewControllable.popViewController(animated: true)
        moitListRouter = nil
        detachChild(router)
    }
}

// TODO: - 삭제
extension RootRouter {
    
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
