//
//  MOITWebInteractor.swift
//  MOITWebImpl
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import RIBs
import RxSwift
import MOITWeb

protocol MOITWebRouting: ViewableRouting {
}

protocol MOITWebPresentable: Presentable {
    var listener: MOITWebPresentableListener? { get set }
    func render(with path: String)
}

final class MOITWebInteractor: PresentableInteractor<MOITWebPresentable>,
                                MOITWebInteractable,
                                MOITWebPresentableListener {

    // MARK: - Properties
    
    weak var router: MOITWebRouting?
    weak var listener: MOITWebListener?

    private let path: String
    
    // MARK: - LifeCycles
    
    init(
        presenter: MOITWebPresentable,
        path: String
    ) {
        self.path = path
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        self.presenter.render(with: self.path)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    deinit { debugPrint("\(self) deinit") }
}

// MARK: - MOITWebPresentableListener

extension MOITWebInteractor {
    func didSwipeBack() {
        self.listener?.shouldDetach(withPop: false)
    }
}
