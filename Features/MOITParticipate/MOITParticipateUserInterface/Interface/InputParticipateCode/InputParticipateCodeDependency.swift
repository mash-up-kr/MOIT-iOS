//
//  InputParticipateCodeDependency.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/07/11.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork
import MOITDetailDomain

import RIBs

public protocol InputParticipateCodeDependency: Dependency {
	var network: Network { get }
	var moitDetailUseCase: MOITDetailUsecase { get }
}
