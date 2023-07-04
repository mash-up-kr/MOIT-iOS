//
//  ParticipateEndpoint.swift
//  MOITParticipateDataImpl
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork
import MOITParticipateData

enum ParticipateEndpoint {
	
	static func postParticipateCode(with request: MOITParticipateRequest) -> Endpoint<MOITParticipateDTO> {
		
		return Endpoint(
			path: "moit/join",
			method: .post,
			headers: [:],
			parameters: .body(request)
		)
	}
}
