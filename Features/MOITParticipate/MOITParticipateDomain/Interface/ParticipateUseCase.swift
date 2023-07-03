//
//  ParticipateUseCase.swift
//  MOITParticipateDomain
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITParticipateData

import RxSwift

public protocol ParticipateUseCase {
	func execute(with request: MOITParticipateRequest) -> Single<MOITParticipateDTO>
}
