//
//  MOITDetailRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITDetail
import FineUserInterface

import RIBs

protocol MOITDetailInteractable: Interactable,
                                 MOITDetailAttendanceListener,
								 FineListListener {
    var router: MOITDetailRouting? { get set }
    var listener: MOITDetailListener? { get set }
}

protocol MOITDetailViewControllable: ViewControllable {
    func addChild(viewController: ViewControllable)
}

final class MOITDetailRouter: ViewableRouter<MOITDetailInteractable, MOITDetailViewControllable>,
                              MOITDetailRouting {

    private let attendanceBuiler: MOITDetailAttendanceBuildable
    private var attendacneRouter: ViewableRouting?
	
	private let fineListBuilder: FineListBuildable
	private var fineListRouter: ViewableRouting?
    
    init(
        interactor: MOITDetailInteractable,
        viewController: MOITDetailViewControllable,
        attendanceBuiler: MOITDetailAttendanceBuildable,
		fineListBuilder: FineListBuildable
    ) {
        self.attendanceBuiler = attendanceBuiler
		self.fineListBuilder = fineListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachAttendance(moitID: String) {
        guard attendacneRouter == nil else { return }
        let router = self.attendanceBuiler.build(
            withListener: self.interactor,
            moitID: moitID
        )
        self.attendacneRouter = router
        self.attachChild(router)
        self.viewController.addChild(viewController: router.viewControllable)
    }
	
	func attachFineList(moitID: String) {
		guard fineListRouter == nil else { return }
		
		let router = fineListBuilder.build(
			withListener: interactor,
			moitID: moitID
		)
		fineListRouter = router
		attachChild(router)
		viewController.addChild(viewController: router.viewControllable)
	}
}
