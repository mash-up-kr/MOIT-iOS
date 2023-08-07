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
                           LoggedOutListener,
                           MOITListListener
{
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ViewControllable {
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
                        RootRouting {

    // MARK: - Initializers

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        moitListBuilder: MOITListBuildable,
        loggedOutBuilder: LoggedOutBuildable
    ) {
        self.moitListBuilder = moitListBuilder
        self.authBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    // MARK: - Auth
    
    private let authBuilder: LoggedOutBuildable
    private var authRouter: ViewableRouting?

    
    func routeToAuth() {
        if authRouter != nil { return }
        
        let router = authBuilder.build(withListener: interactor)
        
        self.authRouter = router
        attachChild(router)
        
        router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        router.viewControllable.uiviewController.modalTransitionStyle = .crossDissolve
        self.viewController.uiviewController.present(
            router.viewControllable.uiviewController,
            animated: false
        )
    }
    
    func detachAuth(_ completion: (() -> Void)?) {
        guard let router = authRouter else { return }
        
        authRouter = nil
        detachChild(router)
//        router.viewControllable.uiviewController.modalTransitionStyle = .crossDissolve
        viewController.uiviewController.dismiss(animated: true) {
            completion?()
        }
    }
    
    private func detachAll() {
        
    }
    
    // MARK: - MOITList
    
    private let moitListBuilder: MOITListBuildable
    private var moitListRouter: ViewableRouting?
    private var moitListActionableItem: MOITListActionableItem?
    
    @discardableResult
    func routeToMOITList() -> MOITListActionableItem? {
        if moitListRouter != nil {
            return moitListActionableItem
        }
        
        let (router, actionableItem) = moitListBuilder.build(withListener: interactor)
        moitListActionableItem = actionableItem
        moitListRouter = router
        attachChild(router)
        
        let navigationController = UINavigationController(
            rootViewController: router.viewControllable.uiviewController
        )
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        self.viewController.uiviewController.present(
            navigationController,
            animated: false
        )
        return actionableItem
    }
    
    func detachMOITList() {
        guard let router = moitListRouter else { return }
        
        moitListRouter = nil
        detachChild(router)
        viewControllable.dismiss(completion: nil)
    }
}
