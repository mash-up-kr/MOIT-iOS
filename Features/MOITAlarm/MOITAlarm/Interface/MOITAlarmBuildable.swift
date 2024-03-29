//
//  MOITAlarmBuildable.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RIBs

public protocol MOITAlarmBuildable: Buildable {
    func build(withListener listener: MOITAlarmListener) -> ViewableRouting
}
