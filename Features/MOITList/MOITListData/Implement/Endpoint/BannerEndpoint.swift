//
//  BannerEndpoint.swift
//  MOITListData
//
//  Created by kimchansoo on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITListData
import MOITNetwork

struct BannerEndpoint {
    
    static func fetchBannerList() -> Endpoint<BannerDTO> {
        Endpoint(
            path: "/api/v1/banner",
            method: .get
        )
    }
}

