//
//  FineListInteractor.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift

import FineUserInterface

protocol FineListRouting: ViewableRouting { }

protocol FineListPresentable: Presentable {
    var listener: FineListPresentableListener? { get set }
}

final class FineListInteractor: PresentableInteractor<FineListPresentable>, FineListInteractable, FineListPresentableListener {

    weak var router: FineListRouting?
    weak var listener: FineListListener?

    override init(presenter: FineListPresentable) {
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
