//
//  RootInteractor.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import RxSwift
import MOITWebImpl
import MOITWeb

protocol RootRouting: ViewableRouting {
    func routeToMoitWeb(path: MOITWebPath)
    func detachWeb(withPop: Bool)
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {
}

final class RootInteractor: PresentableInteractor<RootPresentable>,
                            RootInteractable,
                            RootPresentableListener {
    
    weak var router: RootRouting?
    
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapCreateButton() {
        self.router?.routeToMoitWeb(path: .register)
    }
    
    func didTapAttendanceButton() {
        self.router?.routeToMoitWeb(path: .attendance)
    }
    
    func didTapModifyButton(id: String) {
        self.router?.routeToMoitWeb(path: .modify(id: id))
    }
    
    func didTapAttendanceResultButton() {
        self.router?.routeToMoitWeb(path: .attendanceResult)
    }
    deinit { debugPrint("\(self) deinit") }
}

extension RootInteractor {
    func shouldDetach(withPop: Bool) {
        self.router?.detachWeb(withPop: withPop)
    }
}
