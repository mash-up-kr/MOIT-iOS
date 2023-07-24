//
//  MOITDetailRepositoryImpl.swift
//  MOITDetailDataImpl
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetailData
import RxSwift
import MOITNetwork

public final class MOITDetailRepositoryImpl: MOITDetailRepository {
    
    private let network: Network
    
    public init(network: Network) {
        self.network = network
        print("init", String(describing: self))
    }
    
    deinit { debugPrint("\(self) deinit") }
    
    public func fetchDetail(moitID: String) -> Single<MOITDetailModel> {
        network.request(with: MOITDetailRequestable(moitID: moitID))
    }
    
    public func fetchAttendance(moitID: String) -> Single<MOITAllAttendanceModel> {
        network.request(with: MOITAttendanceRequestable(moitID: moitID))
    }
}
