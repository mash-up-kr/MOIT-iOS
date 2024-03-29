//
//  MOITDetailListener.swift
//  MOITDetail
//
//  Created by 송서영 on 2023/06/10.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol MOITDetailListener: AnyObject {
    func moitDetailDidSwipeBack()
    func moitDetailDidTapBackButton()
}
