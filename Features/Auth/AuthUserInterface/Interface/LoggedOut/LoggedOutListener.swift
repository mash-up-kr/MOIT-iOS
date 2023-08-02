//
//  LoggedOutListener.swift
//  SignInUserInterface
//
//  Created by 최혜린 on 2023/06/19.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import RIBs

public protocol LoggedOutListener: AnyObject {
    
    func didCompleteAuth()
}
