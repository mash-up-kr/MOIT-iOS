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
    var updateFcmTokenUseCase: UpdateFcmTokenUseCase { get }
    var executeDeeplinkObservable: Observable<String> { get }
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
    
    private func executeDeepLink(type: DeepLinkType, query: String) {
        switch type {
        case .home:
            RootWorkflow()
                .subscribe(self)
                .disposeOnDeactivate(interactor: self)
            
        case .details:
            guard let id = query.split(separator: "=").last else { return }
            MOITDetailWorkflow(id: "\(id)")
                .subscribe(self)
                .disposeOnDeactivate(interactor: self)
            
        case .attendance:
            guard let id = query.split(separator: "=").last else { return }
            MOITAttendanceWorkflow(id: "\(id)")
                .subscribe(self)
                .disposeOnDeactivate(interactor: self)
            
        case .attendanceResult:
            guard let id = query.split(separator: "=").last else { return }
            AttendanceResultWorkflow(id: "\(id)")
                .subscribe(self)
                .disposeOnDeactivate(interactor: self)
            
        case .fine:
            let params = query.split(separator: "&")
            let moitId = params.first?.split(separator: "=").last ?? ""
            let fineId = params.last?.split(separator: "=").last ?? ""
            
            FineWorkflow(moitID: "\(moitId)", fineID: "\(fineId)")
                .subscribe(self)
                .disposeOnDeactivate(interactor: self)
        }
    }
    
    private func createTypeAndQuery(scheme: String) -> (type: DeepLinkType, query: String)? {
        guard let path = scheme.split(separator: "://").last?.split(separator: "?").first,
              let query = scheme.split(separator: "://").last?.split(separator: "?").last,
              let type =  DeepLinkType(rawValue: "\(path)") else { return nil }
        return (type, "\(query)")
    }
    
    private func bind() {
        self.dependency.executeDeeplinkObservable
            .subscribe(onNext: { [weak self] urlString in
                guard let (type, query) = self?.createTypeAndQuery(scheme: urlString) else { return }
                self?.executeDeepLink(type: type, query: query)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    private func configureFCMToken() {
        dependency.fcmTokenObservable
            .withUnretained(self)
            .flatMap { owner, token in
                owner.dependency.updateFcmTokenUseCase.execute(token: token).asObservable()
            }
            .subscribe()
            .disposeOnDeactivate(interactor: self)
    }
}

// MARK: - RootPresentable

extension RootInteractor {
    func viewDidAppear() {
        configureRIB()
        bind()
        configureFCMToken()
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
    
    func didTapAlarm(scheme: String) {
        guard let (type, query) = createTypeAndQuery(scheme: scheme) else { return }
        executeDeepLink(type: type, query: query)
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
