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
import MOITWeb

public protocol MOITListActionableItem: AnyObject {
    func routeToDetail(id: String) -> Observable<(MOITDetailActionableItem, ())>
    func routeToMOITAttendance(id: String) -> Observable<(MOITWebActionableItem, ())>
    func routeToAttendanceResult(id: String) -> Observable<(MOITWebActionableItem, ())>
}
