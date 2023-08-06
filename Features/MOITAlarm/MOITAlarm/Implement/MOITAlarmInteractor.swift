//
//  MOITAlarmInteractor.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs
import RxSwift
import MOITAlarm

protocol MOITAlarmRouting: ViewableRouting {
    
}

protocol MOITAlarmPresentable: Presentable {
    var listener: MOITAlarmPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

final class MOITAlarmInteractor: PresentableInteractor<MOITAlarmPresentable>, MOITAlarmInteractable, MOITAlarmPresentableListener {

    weak var router: MOITAlarmRouting?
    weak var listener: MOITAlarmListener?

    override init(presenter: MOITAlarmPresentable) {
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
	
	func didSwipeBack() {
		listener?.didSwipeBackAlarm()
	}
}
