//
//  FineListBuildable.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol FineListBuildable: Buildable {
	func build(
		withListener listener: FineListListener,
		moitID: Int
    ) -> (router: ViewableRouting, actionableItem: FineActionableItem)
}
