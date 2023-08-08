//
//  AuthorizePaymentListener.swift
//  FineUserInterface
//
//  Created by 최혜린 on 2023/06/26.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol AuthorizePaymentListener: AnyObject {
	func authorizePaymentDismissButtonDidTap()
	func didSuccessPostFineEvaluate()
	func didSuccessAuthorizeFine(isConfirm: Bool)
	func authorizePaymentDidSwipeBack()
}
