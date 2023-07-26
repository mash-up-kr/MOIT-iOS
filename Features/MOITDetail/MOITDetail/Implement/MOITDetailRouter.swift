//
//  MOITDetailRouter.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import MOITDetail
import MOITShare

protocol MOITDetailInteractable: Interactable,
                                 MOITDetailAttendanceListener,
                                 MOITUsersListener,
                                 ShareListener {
    var router: MOITDetailRouting? { get set }
    var listener: MOITDetailListener? { get set }
}

protocol MOITDetailViewControllable: ViewControllable {
    func addChild(viewController: ViewControllable)
}

final class MOITDetailRouter: ViewableRouter<MOITDetailInteractable, MOITDetailViewControllable>,
                              MOITDetailRouting {
    
    init(
        interactor: MOITDetailInteractable,
        viewController: MOITDetailViewControllable,
        attendanceBuiler: MOITDetailAttendanceBuildable,
        moitUserBuilder: MOITUsersBuildable,
        shareBuilder: ShareBuildable
    ) {
        self.moitUserBuilder = moitUserBuilder
        self.attendanceBuiler = attendanceBuiler
        self.shareBuilder = shareBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - MOITDetailAttendance
    
    private let attendanceBuiler: MOITDetailAttendanceBuildable
    private var attendacneRouter: ViewableRouting?
    
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
    
    func detachMOITUsers() {
        guard let moitUserRouter else { return }
        self.moitUserRouter = nil
        self.detachChild(moitUserRouter)
        self.viewController.uiviewController.navigationController?.popViewController(animated: true)
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
    
}
