//
//  FineListListener.swift
//  FineUserInterfaceImpl
//
//  Created by 최혜린 on 2023/06/22.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol FineListListener: AnyObject {
	func fineListViewDidTap(
		moitID: Int,
		fineID: Int,
		isMaster: Bool
	)
}
