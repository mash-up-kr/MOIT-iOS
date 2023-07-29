//
//  MOITSettingRouter.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITSetting

protocol MOITSettingInteractable: Interactable {
    var router: MOITSettingRouting? { get set }
    var listener: MOITSettingListener? { get set }
}

protocol MOITSettingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITSettingRouter: ViewableRouter<MOITSettingInteractable, MOITSettingViewControllable>, MOITSettingRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MOITSettingInteractable, viewController: MOITSettingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
