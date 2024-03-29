//
//  SignUpDependency.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import AuthDomain
import MOITListUserInterface

import RIBs

public protocol SignUpDependency: Dependency
{
    
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { get }
    var signUpUseCase: SignUpUseCase { get }
    var saveTokenUseCase: SaveTokenUseCase { get }
}
