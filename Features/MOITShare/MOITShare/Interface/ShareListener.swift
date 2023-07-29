//
//  MOITShareListener.swift
//  MOITShare
//
//  Created by 송서영 on 2023/07/27.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol ShareListener: AnyObject {
   func didSuccessLinkCopy()
    func didTapDimmedView()
}
