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

protocol MOITSettingRouting: ViewableRouting {
    func routeToProfileEdit()
    func detachProfileEdit()
    func routeToWeb(path: MOITWebPath)
    func detachWeb(withPop: Bool)
}

protocol MOITSettingPresentable: Presentable {
    var listener: MOITSettingPresentableListener? { get set }
    func showLogoutAlert(title: String, message: String)
    func showWithdrawAlert(title: String, message: String)
}

final class MOITSettingInteractor: PresentableInteractor<MOITSettingPresentable>,
                                   MOITSettingInteractable,
                                   MOITSettingPresentableListener {
    
    weak var router: MOITSettingRouting?
    weak var listener: MOITSettingListener?
    
    override init(presenter: MOITSettingPresentable) {
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
    func didTapBackButton() {
        self.listener?.didTapBackButton()
    }
    func didTap프로필수정() {
        self.router?.routeToProfileEdit()
    }
    func didTap개인정보처리방침() {
        self.router?.routeToWeb(path: .개인정보처리방침)
    }
    func didTap서비스이용약관() {
        self.router?.routeToWeb(path: .서비스이용약관)
    }
    func didTap피드백() {
        
    }
    func didTap계정삭제() {
        self.presenter.showWithdrawAlert(
            title: "모잇 계정을 삭제할까요?",
            message: """
계정 삭제 후엔
되돌릴 수 없어요!
""")
    }
    func didTap로그아웃() {
        self.presenter.showLogoutAlert(
            title: "모잇에 로그아웃 할까요?",
            message: "안녕히가세용 (' ᵔ '｡)"
        )
    }
    
    func didTap삭제Action() {
        
    }
    func didTap로그아웃Action() {
        
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
