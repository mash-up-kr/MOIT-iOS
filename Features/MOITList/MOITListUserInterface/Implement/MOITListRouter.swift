//
//  MOITListRouter.swift
//  MOITListUserInterfaceImpl
//
//  Created by kimchansoo on 2023/06/25.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import MOITListUserInterface
import MOITWeb
import MOITDetail
import MOITParticipateUserInterface
import MOITSetting
import MOITAlarm
import Utils

import RIBs

protocol MOITListInteractable: Interactable,
                               MOITWebListener,
                               MOITDetailListener,
                               InputParticipateCodeListener,
                               MOITSettingListener,
							   MOITAlarmListener {
    
    var router: MOITListRouting? { get set }
    var listener: MOITListListener? { get set }
}

protocol MOITListViewControllable: ViewControllable {
}

final class MOITListRouter: ViewableRouter<MOITListInteractable, MOITListViewControllable>,
                            MOITListRouting {
    
    init(
        interactor: MOITListInteractable,
        viewController: MOITListViewControllable,
        moitWebBuilder: MOITWebBuildable,
        moitDetailBuilder: MOITDetailBuildable,
        inputParticipateCodeBuilder: InputParticipateCodeBuildable,
        settingBuilder: MOITSettingBuildable,
		alarmBuilder: MOITAlarmBuildable
    ) {
        self.moitWebBuilder = moitWebBuilder
        self.moitDetailBuilder = moitDetailBuilder
        self.inputParticipateCodeBuilder = inputParticipateCodeBuilder
        self.settingBuilder = settingBuilder
		self.alarmBuilder = alarmBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - MOITWeb
    
    private let moitWebBuilder: MOITWebBuildable
    private var moitWebRouters: [ViewableRouting] = []
    
    func attachRegisterMOIT() {
        let (router, _) = moitWebBuilder.build(
            withListener: interactor,
            domain: .frontend,
            path: .register
        )
        self.moitWebRouters.append(router)
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    func detachMOITWeb(withPop: Bool) {
        guard let lastMOITWebRouter = moitWebRouters.popLast() else { return }
        detachChild(lastMOITWebRouter)
        if withPop {
            viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
    }
    private func getKeyboardHeight() -> CGFloat {
        guard let height = UserDefaults.standard.object(forKey: "keyboardHeight") as? CGFloat else {
            return 301
        }
        return height
    }
    
    @discardableResult
    func attachMOITAttendance(id: String) -> MOITWebActionableItem? {
        let (router, actionableItem) = moitWebBuilder.build(
            withListener: interactor,
            domain: .frontend,
            path: .attendance(id: id, keyboardHeight: self.getKeyboardHeight())
        )
        self.moitWebRouters.append(router)
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(
            router.viewControllable.uiviewController,
            animated: true
        )
        return actionableItem
    }
    
    @discardableResult
    func attachMOITAttendanceResult(id: String) -> MOITWebActionableItem? {
        let (router, actionableItem) = moitWebBuilder.build(
            withListener: interactor,
            domain: .frontend,
            path: .attendanceResult(id: id)
        )
        self.moitWebRouters.append(router)
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(
            router.viewControllable.uiviewController,
            animated: true
        )
        return actionableItem
    }
    
    // MARK: - MOITDetail
    
    private let moitDetailBuilder: MOITDetailBuildable
    private var moitDetailRouters: [ViewableRouting] = []
    
    @discardableResult
    func attachMOITDetail(id: String) -> MOITDetailActionableItem? {
        let (router, interactor) = moitDetailBuilder.build(withListener: interactor, moitID: id)
        
        self.moitDetailRouters.append(router)
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(
            router.viewControllable.uiviewController,
            animated: true
        )
        return interactor
    }
    
    func detachMOITDetail(withPop: Bool) {
        guard let lastMOITDetailRouter = moitDetailRouters.popLast() else { return }
        detachChild(lastMOITDetailRouter)
        if withPop {
            viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - InputParticipateCode
    
    private let inputParticipateCodeBuilder: InputParticipateCodeBuildable
    private var inputParticipateCodeRouter: ViewableRouting?
    
    func attachInputParticipateCode() {
        guard inputParticipateCodeRouter == nil else { return }
        let router = inputParticipateCodeBuilder.build(withListener: interactor)
        self.inputParticipateCodeRouter = router
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    func detachInputParticipateCode(onlyPop: Bool) {
        guard let inputParticipateCodeRouter else { return }
        self.inputParticipateCodeRouter = nil
        detachChild(inputParticipateCodeRouter)
        
        viewController.uiviewController.navigationController?.popViewController(animated: true)
        
        if !onlyPop {
            viewController.uiviewController.navigationController?.dismiss(animated: false)
        }
        
    }
    
    // MARK: - Setting
    
    private let settingBuilder: MOITSettingBuildable
    private var settingRouter: ViewableRouting?
    
    func attachSetting() {
        guard settingRouter == nil else { return }
        let router = settingBuilder.build(withListener: interactor)
        settingRouter = router
        attachChild(router)
        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
		
// 서영이 웹뷰 테스트용 ><
//        guard moitWebRouter == nil else { return }
//        let router = moitWebBuilder.build(
//            withListener: interactor,
//            domain: .frontend,
//            path: .attendance(keyboardHeight: getKeyboardHeight())
//        )
//        self.moitWebRouter = router
//        attachChild(router)
//        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    func detachSetting(withPop: Bool) {
        guard let settingRouter else { return }
        self.settingRouter = nil
        detachChild(settingRouter)
        if withPop {
            viewController.uiviewController.navigationController?.popViewController(animated: true)
        }
		
// 서영이 웹뷰 테스트용 ><
//        guard let moitWebRouter else { return }
//        self.moitWebRouter = nil
//        detachChild(moitWebRouter)
//        if withPop {
//            viewController.uiviewController.navigationController?.popViewController(animated: true)
//        }
    }
	
	private let alarmBuilder: MOITAlarmBuildable
	private var alarmRouter: ViewableRouting?
    
    // MARK: - Alarm
    func attachAlarm() {
		if alarmRouter != nil { return }
		
		let router = alarmBuilder.build(withListener: interactor)
		alarmRouter = router
		attachChild(router)
		viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }
    
    func detachAlarm(withPop: Bool) {
		guard let alarmRouter else { return }
		self.alarmRouter = nil
		detachChild(alarmRouter)
		if withPop {
			viewController.uiviewController.navigationController?.popViewController(animated: true)
		}
    }
}
