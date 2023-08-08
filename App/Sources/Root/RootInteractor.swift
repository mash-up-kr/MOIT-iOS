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
import MOITListUserInterface
import RxRelay

protocol RootRouting: Routing {
    func routeToAuth()
    
    @discardableResult
    func routeToMOITList() -> MOITListActionableItem?
    
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
    private let waitForLoginSubject = ReplaySubject<RootActionableItem>.create(bufferSize: 1)
    
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
        self.waitForLoginSubject.onNext(self)
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
            guard let self else { return }
            self.waitForLoginSubject.onNext(self)
            self.router?.routeToMOITList()
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

// MARK: - RootActionableItem

extension RootInteractor: RootActionableItem {
    func waitForLogin() -> Observable<(RootActionableItem, ())> {
        waitForLoginSubject
            .asObservable()
            .map { actionableItem -> (RootActionableItem, ()) in
                return (actionableItem, ())
            }
    }
    
    func routeToMOITList() -> Observable<(MOITListActionableItem, ())> {
        guard let item = router?.routeToMOITList() else { fatalError() }
        return Observable.just((item, ()))
    }
}

// MARK: - Deeplinkable
extension RootInteractor: Deeplinkable {
    func routeToMOITList() {
        RootWorkflow()
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
    
    func routeToDetail(id: String) {
        MOITDetailWorkflow(id: id)
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
    
    func routeToAttendance(id: String) {
        MOITAttendanceWorkflow(id: id)
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
    
    func routeToAttendanceResult(id: String) {
        AttendanceResultWorkflow(id: id)
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
    
    func routeToFine(moitID: String, fineID: String) {
        FineWorkflow(moitID: moitID, fineID: fineID)
            .subscribe(self)
            .disposeOnDeactivate(interactor: self)
    }
}
