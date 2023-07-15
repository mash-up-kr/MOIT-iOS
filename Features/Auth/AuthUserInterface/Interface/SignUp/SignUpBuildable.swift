//
//  SignUpBuildable.swift
//  SignUpUserInterfaceImpl
//
//  Created by 김찬수 on 2023/06/14.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import UIKit

import AuthDomain

import RIBs

public protocol SignUpBuildable: Buildable {
    func build(
		withListener listener: SignUpListener,
		signInResponse: MOITSignInResponse
	) -> ViewableRouting
}
