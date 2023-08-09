//
//  MOITAlarmListener.swift
//  MOITAlarmImpl
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol MOITAlarmListener: AnyObject {
    func didSwipeBackAlarm()
    func didTapBackAlarm()
    func didTapAlarm(scheme: String)
}
