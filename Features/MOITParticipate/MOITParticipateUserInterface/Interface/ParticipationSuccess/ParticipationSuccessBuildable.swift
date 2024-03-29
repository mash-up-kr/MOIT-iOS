//
//  ParticipationSuccessBuildable.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

import MOITDetail

public protocol ParticipationSuccessBuildable: Buildable {
	func build(
		withListener listener: ParticipationSuccessListener,
		withViewModel viewModel: MOITDetailProfileInfoViewModel
	) -> ViewableRouting
}
