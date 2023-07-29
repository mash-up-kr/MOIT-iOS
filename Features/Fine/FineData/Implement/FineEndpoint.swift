//
//  FineEndpoint.swift
//  FineDataImpl
//
//  Created by 최혜린 on 2023/07/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import FineData
import MOITNetwork

enum FineEndpoint {
	static func fetchFineInfo(moitId: Int) -> Endpoint<FineInfo> {
		return Endpoint(
			path: "moit/\(moitId)/fine",
			method: .get
		)
	}
	
	static func fetchFineItem(moitID: Int, fineID: Int) -> Endpoint<FineItem> {
		return Endpoint(
			path: "moit/\(moitID)/fine/\(fineID)",
			method: .get
		)
	}
}