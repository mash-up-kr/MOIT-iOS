//
//  AuthorizePaymentBuildable.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol AuthorizePaymentBuildable: Buildable {
	func build(withListener listener: AuthorizePaymentListener) -> ViewableRouting
}
