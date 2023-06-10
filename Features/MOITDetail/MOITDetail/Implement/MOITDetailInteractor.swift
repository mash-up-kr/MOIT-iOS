//
//  MOITDetailInteractor.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITDetail

protocol MOITDetailRouting: ViewableRouting {
    func attachAttendance()
}

protocol MOITDetailPresentable: Presentable {
    var listener: MOITDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

final class MOITDetailInteractor: PresentableInteractor<MOITDetailPresentable>,
                                  MOITDetailInteractable,
                                  MOITDetailPresentableListener {
    
    func didTapInfoButton(type: MOITDetailInfoViewButtonType) {
        
    }

    weak var router: MOITDetailRouting?
    weak var listener: MOITDetailListener?
    
    private let tabTypes: [MOITDetailTab]

    init(
        tabTypes: [MOITDetailTab],
        presenter: MOITDetailPresentable
    ) {
        self.tabTypes = tabTypes
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func viewDidLoad() {
        self.tabTypes.forEach { type  in
            switch type {
            case .attendance: self.router?.attachAttendance()
            default: return
            }
        }
    }
}
