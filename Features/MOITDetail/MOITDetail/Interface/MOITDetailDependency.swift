//
//  MOITDetailDependency.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailDomain

import RIBs

public protocol MOITDetailDependency: Dependency {
    
    var moitAllAttendanceUsecase: MOITAllAttendanceUsecase { get }
    var moitUserusecase: MOITUserUsecase { get }
    var moitDetailUsecase: MOITDetailUsecase { get }
}
