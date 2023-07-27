//
//  MOITWebListener.swift
//  MOITWeb
//
//  Created by 송서영 on 2023/05/24.
//  Copyright © 2023 chansoo.io. All rights reserved.
//

import Foundation

import AuthDomain

public protocol MOITWebListener: AnyObject {
    func shouldDetach(withPop: Bool)
	func authorizationDidFinish(with signInResponse: MOITSignInResponse)
	func didSignIn(with token: String)
    func didTapShare(code: String)
}
