//
//  SignUpDependency.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import AuthDomain

import RIBs

public protocol SignUpDependency: Dependency {
    
    var fetchRandomNumberUseCase: FetchRandomNumberUseCase { get }
    var postJoinInfoUseCase: PostJoinInfoUseCase { get }
    var profileSelectBuildable: ProfileSelectBuildable { get }
}
