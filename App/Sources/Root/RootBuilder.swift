//
//  RootBuilder.swift
//  App
//
//  Created by 송서영 on 2023/05/22.
//

import RIBs

import MOITWebImpl
import MOITWeb

import AuthData
import AuthDataImpl
import AuthDomain
import AuthDomainImpl
import AuthUserInterface
import AuthUserInterfaceImpl

import MOITListUserInterface
import MOITListUserInterfaceImpl
import MOITListDomain
import MOITListDomainImpl
import MOITListData
import MOITListDataImpl

import TokenManager
import TokenManagerImpl

import MOITNetwork
import MOITNetworkImpl

final class RootComponent: EmptyDependency,
                           MOITWebDependency,
                           RootInteractorDependency,
                           MOITListDependency,
                           LoggedOutDependency,
                           SignUpDependency,
                           ProfileSelectDependency
{
    
    lazy var profileSelectBuildable: AuthUserInterface.ProfileSelectBuildable = ProfileSelectBuilder(dependency: self)
    
    // MARK: - Properties
    
    private let network = NetworkImpl()
    private lazy var moitRepository = MOITRepositoryImpl(network: network)
    private lazy var bannerRepository = BannerRepositoryImpl(network: network)
    private lazy var authRepository = AuthRepositoryImpl(network: network)
    private lazy var tokenManager = TokenManagerImpl()
    
    lazy var fetchMOITListsUseCase: FetchMoitListUseCase = FetchMoitListUseCaseImpl(moitRepository: moitRepository)
    
    lazy var calculateLeftTimeUseCase: CalculateLeftTimeUseCase = CalculateLeftTimeUseCaseImpl()
    
    lazy var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase = FetchBannersUseCaseImpl(repository: bannerRepository)
    
    lazy var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
    
    lazy var signUpUseCase: SignUpUseCase = SignUpUseCaseImpl(authRepository: authRepository)
    
    lazy var saveTokenUseCase: SaveTokenUseCase = SaveTokenUseCaseImpl(tokenManager: tokenManager)
    lazy var fetchTokenUseCase: FetchTokenUseCase = FetchTokenUseCaseImpl(tokenManager: tokenManager)
    
    // MARK: - Initializers
    
    public init() {
        #warning("나중에 지워")
        tokenManager.delete(key: .authorizationToken)
    }
    
    // MARK: - Methods
    
}
// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {
    
    override init(dependency: EmptyDependency) {
        super.init(dependency: dependency)
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    func build() -> LaunchRouting {
        let component = RootComponent()
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController, dependency: component)
        
        let webBuilder = MOITWebBuilder(dependency: component)
        
        let moitListBuilder = MOITListBuilder(dependency: component)
        let authBuilder = LoggedOutBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            moitWebBuilder: webBuilder,
            moitListBuilder: moitListBuilder,
            loggedOutBuilder: authBuilder
        )
    }
}
