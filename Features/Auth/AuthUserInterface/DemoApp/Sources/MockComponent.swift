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
import MOITWeb
import MOITWebImpl

import RIBs
import RxSwift

final class MOCKAuthComponent: Component<EmptyDependency>,
							   LoggedOutDependency,
							   ProfileSelectDependency,
							   SignUpDependency, MOITWebDependency{
	
	init() {
		super.init(dependency: EmptyComponent())
	}
	
	var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
	
//	var postJoinInfoUseCase: PostJoinInfoUseCase = PostJoinInfoUseCaseImpl(joinRepository: MockJoinRepository())
	var postJoinInfoUseCase: PostJoinInfoUseCase = PostJoinInfoUseCaseImpl(joinRepository: MockJoinRepository())
	
	lazy var profileSelectBuildable: ProfileSelectBuildable = {
		return ProfileSelectBuilder(dependency: self)
	}()
	
	lazy var signUpBuildable: SignUpBuildable = {
		return SignUpBuilder(dependency: self)
	}()
	
	lazy var moitWebBuildable: MOITWebBuildable = {
		return MOITWebBuilder(dependency: self)
	}()
}

final class MockJoinRepository: JoinRepository {
	
	func post(imageIndex: Int, name: String, inviteCode: String?) -> Single<Int> {
		Single.just(3)
	}
}
