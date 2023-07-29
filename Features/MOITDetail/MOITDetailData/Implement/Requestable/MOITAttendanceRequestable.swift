//
//  MOITAttendanceRequestable.swift
//  MOITDetailDataImpl
//
//  Created by 송서영 on 2023/07/07.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITNetwork
import MOITDetailData

struct MOITAttendanceRequestable: Requestable {
    typealias Response = MOITAllAttendanceModel
    var path: String { "/api/v1/moit/\(moitID)/attendance" }
    var method: HTTPMethod = .get
    var headers: HTTPHeaders = [:]
    var parameters: HTTPRequestParameter? = nil
    
    private let moitID: String
    
    init(moitID: String) {
        self.moitID = moitID
    }
}
