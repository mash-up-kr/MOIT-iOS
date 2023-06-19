//
//  AppRoot.swift
//  SignUpUserInterfaceDemoApp
//
//  Created by 김찬수 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import SignUpUserInterface
import SignUpUserInterfaceImpl
import SignUpDomain
import SignUpDomainImpl
import SignUpData
import SignUpDataImpl

import RIBs
import RxSwift

final class MOCKSignUpComponent: Component<EmptyDependency>, SignUpDependency {
    
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
    
    var postJoinInfoUseCase: PostJoinInfoUseCase = PostJoinInfoUseCaseImpl(joinRepository: JoinRepositoryMock())
}

final class JoinRepositoryMock: JoinRepository {
    
    func post(name: String, inviteCode: String?) -> Single<Int> {
        Single.just(3)
    }
}
