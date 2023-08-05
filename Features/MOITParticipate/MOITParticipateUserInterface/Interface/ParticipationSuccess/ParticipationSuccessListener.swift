//
//  ParticipationSuccessListener.swift
//  MOITParticipateUserInterface
//
//  Created by 최혜린 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol ParticipationSuccessListener: AnyObject {
	func participationSuccessDismissButtonDidTap()
	func showStudyDetailButtonDidTap(moitID: Int)
}
