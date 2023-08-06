//
//  MOITSettingInteractor.swift
//  MOITSettingImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITSetting
import MOITWeb
import AuthDomain
import TokenManager
import UserNotifications
import UIKit

protocol MOITSettingRouting: ViewableRouting {
    func routeToWeb(path: MOITWebPath)
    func detachWeb(withPop: Bool)
}

protocol MOITSettingPresentable: Presentable {
    var listener: MOITSettingPresentableListener? { get set }
    func showLogoutAlert(title: String, message: String)
    func showWithdrawAlert(title: String, message: String)
    func showErrorAlert(title: String, message: String)
    func configureItems(_ items: [MOITSettingItemType])
}

final class MOITSettingInteractor: PresentableInteractor<MOITSettingPresentable>,
                                   MOITSettingInteractable,
                                   MOITSettingPresentableListener {
    
    weak var router: MOITSettingRouting?
    weak var listener: MOITSettingListener?
    
    private let userUsecase: UserUseCase
    
    init(
        presenter: MOITSettingPresentable,
        userUsecase: UserUseCase
    ) {
        self.userUsecase = userUsecase
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
}

// MARK: - MOITSettingPresentableListener
extension MOITSettingInteractor {
    private func createItems(isOn: Bool) -> [MOITSettingItemType] {
        [
           MOITSettingToggleItemType.앱푸시알림설정(isOn: isOn),
           MOITSettingDividerItemType.divider,
           MOITSettingTitleItemType.개인정보처리방침,
           MOITSettingDividerItemType.divider,
           MOITSettingTitleItemType.서비스이용약관,
           MOITSettingDividerItemType.divider,
           MOITSettingTitleItemType.피드백,
           MOITSettingDividerItemType.divider,
           MOITSettingTitleItemType.계정삭제,
           MOITSettingDividerItemType.divider,
           MOITSettingTitleItemType.로그아웃,
       ]
    }
    func viewDidLoad() {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { [weak self] settings in
            guard let self else { return }
            let isOn = settings.authorizationStatus == .authorized
            let items = self.createItems(isOn: isOn)
            
            DispatchQueue.main.async {
                self.presenter.configureItems(items)
            }
        })
    }
    
    func appMovedToForeground() {
        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { [weak self] settings in
            guard let self else { return }
            let isOn = settings.authorizationStatus == .authorized
            let items = self.createItems(isOn: isOn)
            
            DispatchQueue.main.async {
                self.presenter.configureItems(items)
            }
        })
    }
    
    func didSwipeBack() {
        self.listener?.didSwipeBack()
    }
    
    func didTapBackButton() {
        self.listener?.didTapBackButton()
    }
    
    func didTap개인정보처리방침() {
        self.router?.routeToWeb(path: .개인정보처리방침)
    }
    
    func didTap서비스이용약관() {
        self.router?.routeToWeb(path: .서비스이용약관)
    }
    
    func didTap피드백() {
        self.presenter.showErrorAlert(
            title: "준비중인 서비스입니다.",
            message: "조금만 기다려주세요!"
        )
    }
    
    func didTap계정삭제() {
        self.presenter.showWithdrawAlert(
            title: "모잇 계정을 삭제할까요?",
            message: """
                    계정 삭제 후엔
                    되돌릴 수 없어요!
                    """
        )
    }
    
    func didTap로그아웃() {
        self.presenter.showLogoutAlert(
            title: "모잇에 로그아웃 할까요?",
            message: "안녕히가세용 (' ᵔ '｡)"
        )
    }
    
    func didTap삭제Action() {
        self.userUsecase.withdraw()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self?.listener?.didWithdraw()
            }, onFailure: { [weak self] _ in
                self?.presenter.showErrorAlert(
                    title: "실패했습니다.",
                    message: "다시시도해주세요! (_ _)"
                )
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func didTap로그아웃Action() {
        self.userUsecase.logout()
            .subscribe(onSuccess: { [weak self] _ in
                self?.listener?.didLogout()
            }, onFailure: { [weak self] _ in
                self?.presenter.showErrorAlert(
                    title: "실패했습니다.",
                    message: "다시시도해주세요! (_ _)"
                )
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func didTogglePushAlarm(isOn: Bool) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        presenter.configureItems(self.createItems(isOn: !isOn))
    }
}

// MARK: - MOITWebListener
extension MOITSettingInteractor {
    func didSignIn(with token: String) {
        // do not anything
    }
    func shouldDetach(withPop: Bool) {
        self.router?.detachWeb(withPop: withPop)
    }
    func authorizationDidFinish(with signInResponse: MOITSignInResponse) {
        // do not anything
    }
}
