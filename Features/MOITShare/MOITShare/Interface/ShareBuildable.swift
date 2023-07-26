//
//  MOITShareBuildable.swift
//  MOITShare
//
//  Created by 송서영 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation
import RIBs

public protocol ShareBuildable: Buildable {
    func build(withListener listener: ShareListener, code: String) -> ViewableRouting
}
