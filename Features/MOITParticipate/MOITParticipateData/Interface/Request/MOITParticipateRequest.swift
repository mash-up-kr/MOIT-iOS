//
//  MOITParticipateRequest.swift
//  MOITParticipateDataImpl
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public struct MOITParticipateRequest: Encodable {
	public let userId: Int
	public let invitationCode: String
	
	public init(
		userId: Int,
		invitationCode: String
	) {
		self.userId = userId
		self.invitationCode = invitationCode
	}
}
