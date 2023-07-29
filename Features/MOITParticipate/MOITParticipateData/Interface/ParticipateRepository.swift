//
//  ParticipateRepository.swift
//  MOITParticipateData
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailData

import RxSwift

public protocol ParticipateRepository {
	func postParticipateCode(with request: MOITParticipateRequest) -> Single<MOITDetailModel>
}
