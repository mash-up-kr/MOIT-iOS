//
//  MOITDetailActionableItem.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import FineUserInterface
import RxSwift

public protocol MOITDetailActionableItem: AnyObject {
    func routeToFine() -> Observable<(FineActionableItem, ())>
}
