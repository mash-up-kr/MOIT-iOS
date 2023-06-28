//
//  ProfileSelectListener.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/21.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol ProfileSelectListener: AnyObject {
    
    func profileSelectDidClose()
    func profileSelectDidFinish(imageTypeIdx: Int)
}
