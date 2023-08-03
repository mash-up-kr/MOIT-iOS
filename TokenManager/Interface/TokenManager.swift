//
//  TokenManager.swift
//  TokenManager
//
//  Created by 최혜린 on 2023/07/17.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

public protocol TokenManager {
	
	//TODO: get, save, update generic method로 수정 필요
	
	func get(key: KeychainType) -> String?
	
	@discardableResult
	func save(token: String, with key: KeychainType) -> Bool
	
	@discardableResult
	func update(token: String, with key: KeychainType) -> Bool
	
	@discardableResult
	func delete(key: KeychainType) -> Bool
}
