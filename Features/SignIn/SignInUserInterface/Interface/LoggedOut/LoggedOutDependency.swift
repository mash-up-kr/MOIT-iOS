//
//  LoggedOutDependency.swift
//  SignInUserInterface
//
//  Created by 최혜린 on 2023/07/13.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import SignUpUserInterface

import RIBs

public protocol LoggedOutDependency: Dependency {
	var signUpBuildable: SignUpBuildable { get }
}
