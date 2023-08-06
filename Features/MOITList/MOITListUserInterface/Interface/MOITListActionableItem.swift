//
//  MOITListActionableItem.swift
//  MOITListUserInterface
//
//  Created by 송서영 on 2023/08/06.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import MOITDetail
import RxSwift

public protocol MOITListActionableItem: AnyObject {
    func routeToDetail(id: String) -> Observable<(MOITDetailActionableItem, ())>
}
