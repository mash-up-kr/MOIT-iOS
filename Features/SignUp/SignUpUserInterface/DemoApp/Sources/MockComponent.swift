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

final class MOCKSignUpComponent: Component<EmptyDependency>,
                                 SignUpDependency,
                                 ProfileSelectDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
    
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase = FetchRandomNumberUseCaseImpl()
    
    var postJoinInfoUseCase: PostJoinInfoUseCase = PostJoinInfoUseCaseImpl(joinRepository: MockJoinRepository())
    lazy var profileSelectBuildable: ProfileSelectBuildable = {
        return ProfileSelectBuilder(dependency: self)
    }()
}

final class MockJoinRepository: JoinRepository {
    
    func post(imageIndex: Int, name: String, inviteCode: String?) -> Single<Int> {
        Single.just(3)
    }
}
