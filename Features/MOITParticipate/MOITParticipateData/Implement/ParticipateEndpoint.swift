//
//  ParticipateEndpoint.swift
//  MOITParticipateDataImpl
//
//  Created by 최혜린 on 2023/07/03.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITParticipateData
import MOITNetwork

enum ParticipateEndpoint {
	
	static func postParticipateCode(with request: MOITParticipateRequest) -> Endpoint<ParticipateResponseDTO> {
		
		return Endpoint(
			path: "/api/v1/moit/join",
			method: .post,
			parameters: .body(request)
		)
	}
}
