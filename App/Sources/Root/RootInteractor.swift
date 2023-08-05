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
//        TokenManagerImpl().delete(key: .authorizationToken)
        TokenManagerImpl().save(token: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci1kZWZhdWx0IiwiYXVkIjoiYXV0aDB8YWJjQG5hdmVyLmNvbXw3fGRlZmF1bHQiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2ODg4ODkyOTMsImV4cCI6MTY5MTQ4MTI5MywiaW5mbyI6eyJpZCI6NywicHJvdmlkZXJVbmlxdWVLZXkiOiJhdXRoMHxhYmNAbmF2ZXIuY29tIiwibmlja25hbWUiOiJkZWZhdWx0IiwicHJvZmlsZUltYWdlIjowLCJlbWFpbCI6ImFiY0BuYXZlci5jb20iLCJyb2xlcyI6WyJVU0VSIl19fQ.o9WjiGqNOZSkHGDKQ54b50TUEy-oWvPo1-5Egjw1HXc", with: .authorizationToken)
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
        print("deinit ::: configureRIB")
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
