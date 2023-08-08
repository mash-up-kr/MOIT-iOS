//
//  RootInteractor.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs
import RxSwift
import RxRelay
import MOITWebImpl
import MOITWeb
import AuthDomain
import TokenManagerImpl
import TokenManager

protocol RootRouting: ViewableRouting {
    func routeToAuth()
    func routeToMOITList()
    
    func detachAuth(_ completion: (() -> Void)?)
    func detachMOITList()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: AnyObject {
}

protocol RootInteractorDependency {
    
    var fetchTokenUseCase: FetchTokenUseCase { get }
    var fcmTokenObservable: Observable<String> { get }
}

final class RootInteractor: PresentableInteractor<RootPresentable>,
                            RootInteractable,
                            RootPresentableListener {

    // MARK: - Properties

    weak var router: RootRouting?
    private let dependency: RootInteractorDependency
    
    // MARK: - Initializers
    
    public init(
        presenter: RootPresentable,
        dependency: RootInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    // MARK: - Override
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - Methods
    
    func configureRIB() {
        // 토큰 있는지 확인 후 있으면 moitlist, 안됐으면 auth
        if dependency.fetchTokenUseCase.execute() == nil {
            router?.routeToAuth()
            return
        }
        router?.routeToMOITList()
    }
    
    private func configureFCMToken() {
        dependency.fcmTokenObservable
            .subscribe(onNext: { token in
                // TODO: - 보내라 토큰
            })
            .disposeOnDeactivate(interactor: self)
    }
}

// MARK: - RootPresentable

extension RootInteractor {
    func viewDidAppear() {
        configureRIB()
    }
}

// MARK: - Auth Listener
extension RootInteractor {
    func didCompleteAuth() {
        router?.detachAuth { [weak self] in
            self?.router?.routeToMOITList()
        }
    }
}

// MARK: - MOITListListener
extension RootInteractor {
    func didLogout() {
        self.router?.detachMOITList()
        self.router?.routeToAuth()
    }
    func didWithdraw() {
        self.router?.detachMOITList()
        self.router?.routeToAuth()
    }
}
