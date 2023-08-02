//
//  MOITAlarmRouter.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITAlarm

protocol MOITAlarmInteractable: Interactable {
    var router: MOITAlarmRouting? { get set }
    var listener: MOITAlarmListener? { get set }
}

protocol MOITAlarmViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITAlarmRouter: ViewableRouter<MOITAlarmInteractable, MOITAlarmViewControllable>, MOITAlarmRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MOITAlarmInteractable, viewController: MOITAlarmViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
