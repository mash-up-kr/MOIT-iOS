//
//  SignUpRouter.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import AuthUserInterface
import MOITListUserInterface

import RIBs
import Utils

protocol SignUpInteractable: Interactable,
                             ProfileSelectListener {
    
    var router: SignUpRouting? { get set }
    var listener: SignUpListener? { get set }
}

protocol SignUpViewControllable: ViewControllable {
    
}

final class SignUpRouter: ViewableRouter<SignUpInteractable, SignUpViewControllable>, SignUpRouting {

    // MARK: - Properties
    
    private let profileSelectBuildable: ProfileSelectBuildable
    private var profileSelectRouting: Routing?
    
    // MARK: - Initializers
    
    public init(
        interactor: SignUpInteractable,
        viewController: SignUpViewControllable,
        profileSelectBuildable: ProfileSelectBuildable
    ) {
        self.profileSelectBuildable = profileSelectBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Functions
    
    func attachProfileSelect(currentImageIndex: Int?) {
        if profileSelectRouting != nil { return }
        
        let router = profileSelectBuildable.build(
            withListener: interactor,
            currentImageIndex: currentImageIndex
        )
        
        self.viewControllable.present(
            router.viewControllable,
            animated: true,
            completion: nil
        )
        
        self.profileSelectRouting = router
        attachChild(router)
    }
    
    func detachProfileSelect() {
        guard let router = profileSelectRouting else {
            print("profileSelectRouting is nil")
            return
        }
        
        viewControllable.dismiss(completion: nil)
        self.profileSelectRouting = nil
        
        detachChild(router)
    }
    
}
