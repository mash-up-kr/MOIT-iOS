//
//  MOITSettingDependency.swift
//  MOITSetting
//
//  Created by 송서영 on 2023/07/29.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RIBs
import AuthDomain

public protocol MOITSettingDependency: Dependency {
    var userUseCase: UserUseCase { get }
}
