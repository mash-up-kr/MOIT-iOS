//
//  TokenManagerImpl.swift
//  TokenManagerImpl
//
//  Created by 최혜린 on 2023/07/17.
//  Copyright © 2023 chansoo.MOIT. All rights reserved.
//

import Foundation

import TokenManager
import CSLogger

struct TokenManagerImpl: TokenManager {
	
	// 서비스 아이디, 앱 번들 아이디
	private let service = Bundle.main.bundleIdentifier
	private let keychainClass = kSecClassGenericPassword
	 
	func get(key: KeychainType) -> String? {
		guard let service else { return nil }
		
		let query: [CFString: Any] = [kSecClass: keychainClass,
								kSecAttrService: service,
								kSecAttrAccount: key.rawValue,
								 kSecMatchLimit: kSecMatchLimitOne,
						   kSecReturnAttributes: true,
								 kSecReturnData: true]
		
		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)
		if status != errSecSuccess { return nil }
		
		guard let existingItem = item as? [String: Any],
			  let data = existingItem[kSecAttrGeneric as String] as? Data,
			  let token = try? JSONDecoder().decode(String.self, from: data) else { return nil }
		
		Logger.debug("get token: \(token)")
		
		return token
	}
	
	func save(token: String, with key: KeychainType) -> Bool {
		guard let service else { return false }
		
		let query: [CFString: Any] = [kSecClass: keychainClass,
								kSecAttrService: service,
								kSecAttrAccount: key.rawValue,
								kSecAttrGeneric: token]
		
		let status = SecItemAdd(query as CFDictionary, nil)
		
		Logger.debug("save requested token: \(token), saved token: \(get(key: key))")
		
		return status == errSecSuccess
	}
	
	func update(token: String, with key: KeychainType) -> Bool {
		guard let service else { return false }
		
		let query: [CFString: Any] = [kSecClass: keychainClass,
								kSecAttrService: service,
								kSecAttrAccount: key.rawValue,
								kSecAttrGeneric: token]
		
		let attributes: [CFString: Any] = [kSecAttrAccount: key.rawValue,
										   kSecAttrGeneric: token]
		let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
		
		Logger.debug("update requested token: \(token), updated token: \(get(key: key))")
		
		return status == errSecSuccess
	}
	
	func delete(key: KeychainType) -> Bool {
		guard let service else { return false }
		
		let query: [CFString: Any] = [kSecClass: keychainClass,
								kSecAttrService: service,
								kSecAttrAccount: key.rawValue]
		
		let status = SecItemDelete(query as CFDictionary)
		
		Logger.debug("check empty token: Is \(get(key: key)) empty?")
		
		return status == errSecSuccess
	}
}
