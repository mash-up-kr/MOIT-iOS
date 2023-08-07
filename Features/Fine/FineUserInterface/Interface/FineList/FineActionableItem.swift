//
//  FineActionableItem.swift
//  FineUserInterface
//
//  Created by 송서영 on 2023/08/08.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RxSwift

public protocol FineActionableItem: AnyObject {
    func routeToAuthorizePayment(moitID: String, fineID: String) -> Observable<(AuthorizePaymentActionableItem, ())>
}
