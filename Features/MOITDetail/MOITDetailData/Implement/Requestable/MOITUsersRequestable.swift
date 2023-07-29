//
//  MOITUsersRequestable.swift
//  MOITDetailData
//
//  Created by 송서영 on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITNetwork
import MOITDetailData

struct MOITUsersRequestable: Requestable {
    typealias Response = MOITUserModel
    var path: String { "/api/v1/moit/\(moitID)/users" }
    let method: HTTPMethod = .get
    let headers: HTTPHeaders = [:]
    let parameters: HTTPRequestParameter? = nil
    private let moitID: String
    
    init(moitID: String) {
        self.moitID = moitID
    }
}
