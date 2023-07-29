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

import MOITDetail
import MOITDetailImpl
import MOITDetailDomain
import MOITDetailDomainImpl
import MOITDetailData
import MOITDetailDataImpl

import TokenManager
import TokenManagerImpl

import MOITNetwork
import MOITNetworkImpl

import MOITDetailDomain
import MOITDetailDomainImpl
import MOITDetailData
import MOITDetailDataImpl

final class RootComponent: EmptyDependency,
                           MOITWebDependency,
                           RootInteractorDependency,
                           MOITListDependency,
                           LoggedOutDependency,
                           SignUpDependency,
                           ProfileSelectDependency {
    
    lazy var profileSelectBuildable: AuthUserInterface.ProfileSelectBuildable = ProfileSelectBuilder(dependency: self)
    
    // MARK: - Properties
    let network: Network = NetworkImpl()
    private lazy var moitRepository = MOITRepositoryImpl(network: network)
    private lazy var bannerRepository = BannerRepositoryImpl(network: network)
    private lazy var authRepository = AuthRepositoryImpl(network: network)
    private lazy var detailRepository = MOITDetailRepositoryImpl(network: network)
    private lazy var tokenManager = TokenManagerImpl()
    
    lazy var fetchMOITListsUseCase: FetchMoitListUseCase = FetchMoitListUseCaseImpl(moitRepository: moitRepository)
    
    lazy var calculateLeftTimeUseCase: CalculateLeftTimeUseCase = CalculateLeftTimeUseCaseImpl()
    lazy var moitDetailUseCase: MOITDetailUsecase = MOITDetailUsecaseImpl(repository: detailRepository)
    lazy var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase = FetchBannersUseCaseImpl(repository: bannerRepository)
    
    lazy var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
    
    lazy var signUpUseCase: SignUpUseCase = SignUpUseCaseImpl(authRepository: authRepository)
    
    lazy var saveTokenUseCase: SaveTokenUseCase = SaveTokenUseCaseImpl(tokenManager: tokenManager)
    lazy var fetchTokenUseCase: FetchTokenUseCase = FetchTokenUseCaseImpl(tokenManager: tokenManager)
    
    lazy var moitDetailRepository = MOITDetailRepositoryImpl(network: network)
    lazy var moitAllAttendanceUsecase: MOITAllAttendanceUsecase =  MOITAllAttendanceUsecaseImpl(repository: moitDetailRepository)
    lazy var moitUserusecase: MOITUserUsecase = MOITUserUsecaseImpl(repository: moitDetailRepository)
    lazy var moitDetailUsecase: MOITDetailUsecase = MOITDetailUsecaseImpl(repository: moitDetailRepository)
    
    // MARK: - Initializers
    
    public init() {
//        tokenManager.delete(key: .authorizationToken)
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
