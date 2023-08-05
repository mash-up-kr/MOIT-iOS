//
//  MOITDetailEndpoint.swift
//  MOITDetailDataImpl
//
//  Created by 최혜린 on 2023/08/04.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITDetailData
import MOITNetwork

enum MOITDetailEndpoint {
	
	static func fetchMOITAttendance(moitID: String) -> Endpoint<MOITAllAttendanceModel> {
		return Endpoint(
			path: "moit/\(moitID)/attendance",
			method: .get
		)
	}
	
	static func fetchMOITDetail(moitID: String) -> Endpoint<MOITDetailModel> {
		return Endpoint(
			path: "moit/\(moitID)",
			method: .get
		)
	}
	
	static func fetchMOITUsers(moitID: String) -> Endpoint<MOITUserModel> {
		return Endpoint(
			path: "moit/\(moitID)/users",
			method: .get
		)
	}
}
