//
//  MockComponent.swift
//  AuthUserInterfaceDemoApp
//
//  Created by 최혜린 on 2023/07/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import AuthUserInterface
import AuthUserInterfaceImpl
import AuthDomain
import AuthDomainImpl
import AuthData
import AuthDataImpl
import MOITWeb
import MOITWebImpl
import TokenManager
import TokenManagerImpl
import MOITNetworkImpl

import RIBs
import RxSwift

final class MOCKAuthComponent: Component<EmptyDependency>,
							   LoggedOutDependency,
							   ProfileSelectDependency,
							   SignUpDependency,
							   MOITWebDependency,
							   LoggedOutInteractorDependency {
	
	init() {
		super.init(dependency: EmptyComponent())
	}
	
	var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
	
	var postJoinInfoUseCase: PostJoinInfoUseCase = PostJoinInfoUseCaseImpl(joinRepository: MockJoinRepository())
	
	var saveTokenUseCase: SaveTokenUseCase = SaveTokenUseCaseImpl(tokenManager: TokenManagerImpl())
	
	lazy var profileSelectBuildable: ProfileSelectBuildable = {
		return ProfileSelectBuilder(dependency: self)
	}()
	
	lazy var signUpBuildable: SignUpBuildable = {
		return SignUpBuilder(dependency: self)
	}()
	
	lazy var moitWebBuildable: MOITWebBuildable = {
		return MOITWebBuilder(dependency: self)
	}()
	
	var fetchUserInfoUseCase: FetchUserInfoUseCase = FetchUserInfoUseCaseImpl(repository: UserRepositoryImpl(network: NetworkImpl()))
	
	var saveUserIDUseCase: SaveUserIDUseCase = SaveUserIDUseCaseImpl(tokenManager: TokenManagerImpl())
}

final class MockJoinRepository: JoinRepository {
	
	func post(imageIndex: Int, name: String, inviteCode: String?) -> Single<Int> {
		Single.just(3)
	}
}
