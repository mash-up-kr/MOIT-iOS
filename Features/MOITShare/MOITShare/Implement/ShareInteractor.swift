//
//  ShareInteractor.swift
//  ShareImpl
//
//  Created by 송서영 on 2023/06/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITShare
import MOITShareDomain

protocol ShareRouting: ViewableRouting {
}

protocol SharePresentable: Presentable {
    var listener: SharePresentableListener? { get set }
    func presentActivity(code: String)
    func showAlert(title: String, message: String)
}

final class ShareInteractor: PresentableInteractor<SharePresentable>, ShareInteractable, SharePresentableListener {
    
    weak var router: ShareRouting?
    weak var listener: ShareListener?

    private let shareUsecase: MOITShareUsecase
    private let invitationCode: String
    
    init(
        presenter: SharePresentable,
        shareUsecase: MOITShareUsecase,
        invitationCode: String
    ) {
        self.invitationCode = invitationCode
        self.shareUsecase = shareUsecase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

// MARK: - SharePresentableListener

extension ShareInteractor {
    func didTapLinkCopyButton() {
        self.shareUsecase.copyLink(invitationCode)
            .subscribe { [weak self] _ in
                self?.presenter.showAlert(
                    title: "초대 코드 복사 완료",
                    message: "스터디 초대 코드가 복사되었습니다."
                )
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    func didTapAlertOkAction() {
        self.listener?.didSuccessLinkCopy()
    }
    
    func didShareSuccess() {
        self.listener?.didSuccessLinkCopy()
    }

    func didTapDimmedView() {
        self.listener?.didTapDimmedView()
    }
    
    func didTapShareButton() {
        self.presenter.presentActivity(code: invitationCode)
    }
}
