//
//  MOITDetailUsecase.swift
//  MOITDetailDomain
//
//  Created by 송서영 on 2023/06/18.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailData

import RxSwift

public protocol MOITDetailUsecase {
    func moitDetail(with ID: String) -> Single<MOITDetailEntity>
	func convertToMOITDetailEntity(from moitDetailModel: MOITDetailModel) -> MOITDetailEntity
}
