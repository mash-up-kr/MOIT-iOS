//
//  MOITDetailRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import MOITDetail
import FineUserInterface
import MOITShare

import RIBs

protocol MOITDetailInteractable: Interactable,
                                 MOITDetailAttendanceListener,
                                 MOITUsersListener,
								 FineListListener,
								 ShareListener,
								 AuthorizePaymentListener {
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
    
    init(
        interactor: MOITDetailInteractable,
        viewController: MOITDetailViewControllable,
        attendanceBuiler: MOITDetailAttendanceBuildable,
        moitUserBuilder: MOITUsersBuildable,
		fineListBuilder: FineListBuildable,
		shareBuilder: ShareBuildable,
		authorizePaymentBuilder: AuthorizePaymentBuildable
    ) {
        self.moitUserBuilder = moitUserBuilder
        self.attendanceBuiler = attendanceBuiler
		self.fineListBuilder = fineListBuilder
		self.shareBuilder = shareBuilder
		self.authorizePaymentBuilder = authorizePaymentBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - MOITDetailAttendance

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
    
    // MARK: - MOITUsers
    private let moitUserBuilder: MOITUsersBuildable
    private var moitUserRouter: ViewableRouting?
    func attachMOITUsers(moitID: String) {
        guard moitUserRouter == nil else { return }
        let router = moitUserBuilder.build(
            withListener: self.interactor,
            moitID: moitID
        )
        self.moitUserRouter = router
        attachChild(router)
        self.viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    
    func detachMOITUsers(withPop: Bool) {
        guard let moitUserRouter else { return }
        self.moitUserRouter = nil
        self.detachChild(moitUserRouter)
        if withPop {
            self.viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Share
    private let shareBuilder: ShareBuildable
    private var shareRouter: ViewableRouting?
    
    func attachMOITShare(code: String) {
        guard self.shareRouter == nil else { return }
        let router = self.shareBuilder.build(
            withListener: self.interactor,
            code: code
        )
        self.shareRouter = router
        self.attachChild(router)
        self.viewController.uiviewController.present(router.viewControllable.uiviewController, animated: true)
    }
    
    func detachMOITShare() {
        guard let shareRouter else { return }
        self.shareRouter = nil
        detachChild(shareRouter)
        self.viewController.uiviewController.dismiss(animated: true)
    }
    
    private var fineActionableItem: FineActionableItem?
    @discardableResult
	func attachFineList(moitID: Int) -> FineActionableItem? {
        guard fineListRouter == nil else { return self.fineActionableItem }
		
		let (router, interactor) = fineListBuilder.build(
			withListener: interactor,
			moitID: moitID
		)
        fineActionableItem = interactor
		fineListRouter = router
		attachChild(router)
		viewController.addChild(viewController: router.viewControllable)
        return interactor
	}

	// MARK: - AuthorizePayment
	
	private let authorizePaymentBuilder: AuthorizePaymentBuildable
	private var authorizePaymentRouter: ViewableRouting?
	
	func attachAuthorizePayment(
		moitID: Int,
		fineID: Int,
		isMaster: Bool
	) {
		if authorizePaymentRouter != nil { return }
		
		let router = authorizePaymentBuilder.build(
			withListener: interactor,
			moitID: moitID,
			fineID: fineID,
			isMaster: isMaster
		)
		authorizePaymentRouter = router
		attachChild(router)
		
		self.viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
	}
	
	func detachAuthorizePayment(completion: (() -> Void)?, withPop: Bool) {
		guard let router = authorizePaymentRouter else { return }
		
		authorizePaymentRouter = nil
		detachChild(router)
		
		if withPop {
			self.viewController.uiviewController.navigationController?.popViewController(animated: true)
		}
		
		if let completion { completion() }
	}
}
