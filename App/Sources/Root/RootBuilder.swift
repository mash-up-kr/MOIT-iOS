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

import MOITParticipateDomain
import MOITParticipateDomainImpl
import MOITParticipateData
import MOITParticipateDataImpl

import FineDomain
import FineDomainImpl
import FineData
import FineDataImpl

import MOITAlarmData
import MOITAlarmDataImpl
import MOITAlarmDomain
import MOITAlarmDomainImpl

final class RootComponent: Component<EmptyDependency>,
                           MOITWebDependency,
                           RootInteractorDependency,
                           MOITListDependency,
                           LoggedOutDependency,
                           SignUpDependency,
                           ProfileSelectDependency {
    
    let network: Network = NetworkImpl()
    let tokenManager: TokenManager = TokenManagerImpl()
    
    // MARK: Repository
    private lazy var fineRepository = FineRepositoryImpl(network: network)
    private lazy var moitRepository: MOITRepository = MOITRepositoryImpl(network: network)
    private lazy var bannerRepository: BannerRepository = BannerRepositoryImpl(network: network)
    private lazy var authRepository: AuthRepository = AuthRepositoryImpl(network: network)
    private lazy var detailRepository: MOITDetailRepository = MOITDetailRepositoryImpl(network: network)
    private lazy var userRepository: UserRepository = UserRepositoryImpl(network: network)
    private lazy var moitDetailRepository: MOITDetailRepository = MOITDetailRepositoryImpl(network: network)
    private lazy var participateRepository: ParticipateRepositoryImpl = ParticipateRepositoryImpl(network: network)
	private lazy var alarmRepository: MOITAlarmRepositoryImpl = MOITAlarmRepositoryImpl(network: network)
    
    // MARK: Usecase
    lazy var compareUserIDUseCase: CompareUserIDUseCase = CompareUserIDUseCaseImpl(tokenManager: tokenManager)
    lazy var fetchFineInfoUseCase: FetchFineInfoUseCase = FetchFineInfoUseCaseImpl(fineRepository: fineRepository)
    lazy var filterMyFineListUseCase: FilterMyFineListUseCase = FilterMyFineListUseCaseImpl(tokenManager: tokenManager)
    lazy var convertAttendanceStatusUseCase: ConvertAttendanceStatusUseCase = ConvertAttendanceStatusUseCaseImpl()
    lazy var fetchFineItemUseCase: FetchFineItemUseCase = FetchFineItemUseCaseImpl(fineRepository: fineRepository)
    lazy var postFineEvaluateUseCase: PostFineEvaluateUseCase = PostFineEvaluateUseCaseImpl(repository: fineRepository)
    lazy var postMasterAuthorizeUseCase: PostMasterAuthorizeUseCase = PostMasterAuthorizeUseCaseImpl(repository: fineRepository)
    lazy var fetchUserInfoUseCase: FetchUserInfoUseCase = FetchUserInfoUseCaseImpl(repository: userRepository)
    lazy var saveUserIDUseCase: SaveUserIDUseCase = SaveUserIDUseCaseImpl(tokenManager: tokenManager)
    lazy var fetchMOITListsUseCase: FetchMoitListUseCase = FetchMoitListUseCaseImpl(moitRepository: moitRepository)
    lazy var calculateLeftTimeUseCase: CalculateLeftTimeUseCase = CalculateLeftTimeUseCaseImpl()
    lazy var moitDetailUseCase: MOITDetailUsecase = MOITDetailUsecaseImpl(repository: detailRepository)
    var moitDetailUsecase: MOITDetailUsecase { moitDetailUseCase }
    lazy var fetchPaneltyToBePaiedUseCase: FetchBannersUseCase = FetchBannersUseCaseImpl(repository: bannerRepository)
    lazy var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
    lazy var signUpUseCase: SignUpUseCase = SignUpUseCaseImpl(authRepository: authRepository)
    lazy var saveTokenUseCase: SaveTokenUseCase = SaveTokenUseCaseImpl(tokenManager: tokenManager)
    lazy var fetchTokenUseCase: FetchTokenUseCase = FetchTokenUseCaseImpl(tokenManager: tokenManager)
    lazy var moitAllAttendanceUsecase: MOITAllAttendanceUsecase =  MOITAllAttendanceUsecaseImpl(repository: moitDetailRepository)
    lazy var moitUserusecase: MOITUserUsecase = MOITUserUsecaseImpl(repository: moitDetailRepository)
    lazy var participateUseCase: ParticipateUseCase = ParticipateUseCaseImpl(
        participateRepository: participateRepository
    )
    lazy var userUseCase: UserUseCase = UserUseCaseImpl(
        userRepository: userRepository,
        tokenManager: tokenManager
    )
	lazy var fetchNotificationUseCase: FetchNotificationListUseCase = FetchNotificationListUseCaseImpl(
		repository: alarmRepository
	)
    
    override init(dependency: EmptyDependency = EmptyComponent()) {
        super.init(dependency: dependency)
    }
}
// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> (LaunchRouting, Deeplinkable)
}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {
    
    override init(dependency: EmptyDependency) {
        super.init(dependency: dependency)
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    func build() -> (LaunchRouting, Deeplinkable) {
        let component = RootComponent()
        let viewController = RootViewController()
        let interactor = RootInteractor(
            presenter: viewController,
            dependency: component
        )

        let moitListBuilder = MOITListBuilder(dependency: component)
        let authBuilder = LoggedOutBuilder(dependency: component)
        
        let router = RootRouter(
            interactor: interactor,
            viewController: viewController,
            moitListBuilder: moitListBuilder,
            loggedOutBuilder: authBuilder
        )
        return (router, interactor)
    }
}
