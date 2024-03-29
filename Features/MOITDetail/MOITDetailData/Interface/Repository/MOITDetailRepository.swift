//
//  MOITDetailRepository.swift
//  MOITDetailData
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol MOITDetailRepository: AnyObject {
    func fetchDetail(moitID: String) -> Single<MOITDetailModel>
    func fetchAttendance(moitID: String) -> Single<MOITAllAttendanceModel>
    func fetchUesrs(moitID: String) -> Single<MOITUserModel>
}
