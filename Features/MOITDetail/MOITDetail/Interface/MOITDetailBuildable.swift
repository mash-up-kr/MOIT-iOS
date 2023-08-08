//
//  MOITDetailBuildable.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RIBs

public protocol MOITDetailBuildable: Buildable {
    func build(
        withListener listener: MOITDetailListener,
        moitID: String
    ) -> (router: ViewableRouting, actionableItem: MOITDetailActionableItem)
}
