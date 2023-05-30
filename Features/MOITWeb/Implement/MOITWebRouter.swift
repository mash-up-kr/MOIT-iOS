//
//  MOITWebRouter.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import RIBs
import MOITWeb

protocol MOITWebInteractable: Interactable {
    var router: MOITWebRouting? { get set }
    var listener: MOITWebListener? { get set }
}

protocol MOITWebViewControllable: ViewControllable {
}

final class MOITWebRouter: ViewableRouter<MOITWebInteractable, MOITWebViewControllable>,
                            MOITWebRouting {

    override init(
        interactor: MOITWebInteractable,
        viewController: MOITWebViewControllable
    ) {
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
    
    deinit { debugPrint("\(self) deinit") }
}
