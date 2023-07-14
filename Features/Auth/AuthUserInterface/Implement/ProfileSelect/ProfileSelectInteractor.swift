//
//  ProfileSelectInteractor.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//
import SignUpUserInterface

import RIBs
import RxSwift

protocol ProfileSelectRouting: ViewableRouting {
    
}

protocol ProfileSelectPresentable: Presentable {
    var listener: ProfileSelectPresentableListener? { get set }
    
    func updateProfileIndex(index: Int?)
}

final class ProfileSelectInteractor: PresentableInteractor<ProfileSelectPresentable>, ProfileSelectInteractable, ProfileSelectPresentableListener {

    weak var router: ProfileSelectRouting?
    weak var listener: ProfileSelectListener?

    init(presenter: ProfileSelectPresentable, currentImageIndex: Int?) {
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.updateProfileIndex(index: currentImageIndex)
    }

    deinit {
        debugPrint("\(self) deinit")
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension ProfileSelectInteractor {
    
    func didTapSelectButton(with profileTypeIdx: Int) {
        listener?.profileSelectDidFinish(imageTypeIdx: profileTypeIdx)
    }
    
    func didTapDimmedView() {
        listener?.profileSelectDidClose()
    }
}
