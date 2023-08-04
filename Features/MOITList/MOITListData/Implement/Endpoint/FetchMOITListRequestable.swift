//
//  MOITRequestable.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/23.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITNetwork
import MOITListData

struct FetchMOITListEndpoint {
	
	static func fetchMOITList() -> Endpoint<MOITListDTO> {
		Endpoint(
			path: "moit",
			method: .get
		)
	}
}
