//
//  MOITDetailRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetail

protocol MOITDetailInteractable: Interactable,
                                 MOITDetailAttendanceListener {
    var router: MOITDetailRouting? { get set }
    var listener: MOITDetailListener? { get set }
}

protocol MOITDetailViewControllable: ViewControllable {
    func addChild(viewController: ViewControllable)
}

final class MOITDetailRouter: ViewableRouter<MOITDetailInteractable, MOITDetailViewControllable>, MOITDetailRouting {

    private let attendanceBuiler: MOITDetailAttendanceBuildable
    private var attendacneRouter: ViewableRouting?
    
    init(
        interactor: MOITDetailInteractable,
        viewController: MOITDetailViewControllable,
        attendanceBuiler: MOITDetailAttendanceBuildable
    ) {
        self.attendanceBuiler = attendanceBuiler
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachAttendance() {
        guard attendacneRouter == nil else { return }
        let router = self.attendanceBuiler.build(withListener: self.interactor)
        self.attendacneRouter = router
        self.attachChild(router)
        self.viewController.addChild(viewController: router.viewControllable)
    }
}
