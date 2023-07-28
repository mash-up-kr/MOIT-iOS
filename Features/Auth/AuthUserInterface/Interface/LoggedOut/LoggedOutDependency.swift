//
//  LoggedOutDependency.swift
//  SignInUserInterface
//
//  Created by 최혜린 on 2023/07/13.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import MOITWeb
import AuthDomain

import RIBs

public protocol LoggedOutDependency: Dependency {
	var signUpBuildable: SignUpBuildable { get }
	var moitWebBuildable: MOITWebBuildable { get }
	var saveTokenUseCase: SaveTokenUseCase { get }
	var fetchUserInfoUseCase: FetchUserInfoUseCase { get }
	var saveUserIDUseCase: SaveUserIDUseCase { get }
}
