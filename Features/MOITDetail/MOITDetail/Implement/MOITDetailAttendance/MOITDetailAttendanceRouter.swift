//
//  MOITDetailAttendanceRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

protocol MOITDetailAttendanceInteractable: Interactable {
    var router: MOITDetailAttendanceRouting? { get set }
    var listener: MOITDetailAttendanceListener? { get set }
}

protocol MOITDetailAttendanceViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MOITDetailAttendanceRouter: ViewableRouter<MOITDetailAttendanceInteractable, MOITDetailAttendanceViewControllable>, MOITDetailAttendanceRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MOITDetailAttendanceInteractable, viewController: MOITDetailAttendanceViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
