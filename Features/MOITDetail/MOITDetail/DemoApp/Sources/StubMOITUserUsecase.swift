//
//  StubMOITUserUsecase.swift
//  MOITDetailImpl
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailDomain
import RxSwift

final class StubMOITUserUsecase: MOITUserUsecase {
    func fetchMOITUsers(moitID: String) -> Single<[MOITUserEntity]> {
        .just(self.makeUser(count: 100))
    }
    
    private func makeUser(count: Int) -> [MOITUserEntity] {
        (0..<count).map { count in
            MOITUserEntity(
                userID: "\(count)",
                nickname: "김매숑_\(count)",
                profileImage: count
            )
        }
    }
}
