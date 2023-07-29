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
    func routeToMoitWeb(path: MOITWebPath)
    func detachWeb(withPop: Bool)
    
    func routeToAuth()
    func routeToMOITList()
    func detachAuth()
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
                TokenManagerImpl().save(token: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqd3QtdXNlci3shJzrpqwiLCJhdWQiOiJhcHBsZXx6MjJraDd0OTY2QHByaXZhdGVyZWxheS5hcHBsZWlkLmNvbXwyM3zshJzrpqwiLCJpc3MiOiJodHRwczovL2dpdGh1Yi5jb20vbWFzaC11cC1rci9NT0lULWJhY2tlbmQiLCJpYXQiOjE2OTA2NTQxNDIsImV4cCI6MTY5MzI0NjE0MiwiaW5mbyI6eyJpZCI6MjMsInByb3ZpZGVyVW5pcXVlS2V5IjoiYXBwbGV8ejIya2g3dDk2NkBwcml2YXRlcmVsYXkuYXBwbGVpZC5jb20iLCJuaWNrbmFtZSI6IuyEnOumrCIsInByb2ZpbGVJbWFnZSI6MCwiZW1haWwiOiJzdHJpbmciLCJyb2xlcyI6WyJVU0VSIl19fQ.aOCBK2wzqwsyjQAo9W3VFHEbHa-7mGQqb1yZaBi1JO0", with: .authorizationToken)
        configureRIB()

    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - Methods
    
    // 로그인 여부 확인 메소드
    
    func configureRIB() {
        // 토큰 있는지 확인 후 있으면 moitlist, 안됐으면 auth
        if dependency.fetchTokenUseCase.execute() == nil {
            router?.routeToAuth()
            return
        }
        
        router?.routeToMOITList()
    }
    
    func didCompleteAuth() {
        router?.detachAuth()
        router?.routeToMOITList()
    }

}



// TODO: - 삭제

extension RootInteractor {
    func shouldDetach(withPop: Bool) {
        self.router?.detachWeb(withPop: withPop)
    }
}

extension RootInteractor {
    
    func authorizationDidFinish(with signInResponse: MOITSignInResponse) {
        // 뭘 해야함?
    }
    
    func didSignIn(with token: String) {
        // 뭘 해야함?
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
    


}
