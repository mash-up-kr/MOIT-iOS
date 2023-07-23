//
//  MOITUserUsecaseImpl.swift
//  MOITDetailDomainImpl
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailDomain
import RxSwift
import MOITDetailData

public struct MOITUserUsecaseImpl: MOITUserUsecase {
    
    private let repository: MOITDetailRepository
    public init(repository: MOITDetailRepository) {
        self.repository = repository
    }
    
    public func fetchMOITUsers(moitID: String) -> Single<[MOITUserEntity]> {
        self.repository.fetchUesrs(moitID: moitID)
            .map(\.users)
            .map(self.convertToEntitys(_:))
    }
    
    private func convertToEntitys(_ users: [MOITUserModel.User]) -> [MOITUserEntity] {
        users.map { user in
            MOITUserEntity(
                userID: "\(user.userID)",
                nickname: user.nickname,
                profileImage: user.profileImage
            )
        }
    }
}
