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

public struct TokenManagerImpl: TokenManager {
	
	private let keychainClass = kSecClassGenericPassword
	
	public init() {}
	 
	public func get(key: KeychainType) -> String? {
		
		let query: [CFString: Any] = [
			kSecClass: keychainClass,
			kSecAttrAccount: key.rawValue,
			kSecMatchLimit: kSecMatchLimitOne,
			kSecReturnAttributes: true,
			kSecReturnData: true
		]
		
		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)
		guard status != errSecItemNotFound else {
			Logger.debug("Keychain item not found")
			return nil
		}
		guard status == errSecSuccess else {
			Logger.debug("Keychain read Error")
			return nil
		}
		
		guard let existingItem = item as? [String: Any],
			  let data = existingItem[kSecValueData as String] as? Data,
			  let token = String(data: data, encoding: .utf8) else { return nil }
		
		Logger.debug("get token: \(token)")
		
		return token
	}
	
	@discardableResult
	public func save(token: String, with key: KeychainType) -> Bool {
		
		guard let tokenData = token.data(using: .utf8) else { return false }
		
		let query: [CFString: Any] = [
			kSecClass: keychainClass,
			kSecAttrAccount: key.rawValue,
			kSecValueData: tokenData
		]
		
		let status = SecItemAdd(query as CFDictionary, nil)
		
		Logger.debug("save token status: \(status)")
		
		switch status {
		case errSecSuccess:
			Logger.debug("save requested token: \(token), saved token: \(get(key: key))")
			return true
		case errSecDuplicateItem:
			return update(token: token, with: key)
		default:
			return false
		}
	}
	
	@discardableResult
	public func update(token: String, with key: KeychainType) -> Bool {
		
		guard let tokenData = token.data(using: .utf8) else { return false }

		let searchQuery: [CFString: Any] = [
			kSecClass: keychainClass,
			kSecAttrAccount: key.rawValue
		]
		
		let updateQuery: [CFString: Any] = [
			kSecAttrAccount: key.rawValue,
			kSecValueData: tokenData
		]
		
		let status = SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
		
		Logger.debug("update token status: \(status)")
		
		return status == errSecSuccess
		
		switch status {
		case errSecSuccess:
			Logger.debug("update requested token: \(token), updated token: \(get(key: key))")
			return true
		case errSecItemNotFound:
			return save(token: token, with: key)
		default:
			return true
		}
	}
	
	@discardableResult
	public func delete(key: KeychainType) -> Bool {
		
		let query: [CFString: Any] = [
			kSecClass: keychainClass,
			kSecAttrAccount: key.rawValue
		]
		
		let status = SecItemDelete(query as CFDictionary)
		
		Logger.debug("check empty token: Is \(get(key: key)) empty?")
		Logger.debug("delete token status: \(status)")
		
		return status == errSecSuccess
	}
}
