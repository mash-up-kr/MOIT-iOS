//
//  MOITListListener.swift
//  MOITListUserInterface
//
//  Created by kimchansoo on 2023/07/15.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol MOITListListener: AnyObject {
    func didLogout()
    func didWithdraw()
}
