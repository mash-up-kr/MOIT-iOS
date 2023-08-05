//
//  MOITSettingListener.swift
//  MOITSetting
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol MOITSettingListener: AnyObject {
    func didTapBackButton()
    func didSwipeBack()
    func didWithdraw()
    func didLogout()
}
