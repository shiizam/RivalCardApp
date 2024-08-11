//
//  KeychainHelper.swift
//  Rivals
//
//  Created by Cody hancock on 8/6/24.
//

import Foundation
import Security


class KeychainHelper {
    static let shared = KeychainHelper()
    
    func save(_ value: String, forKey key: String) {
        let data = Data(value.utf8)
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        assert(status == errSecSuccess, "Failed to save to Keychain: \(status)")
    }
    
    func get(_ key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func delete(_ key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        SecItemDelete(query)
        
    }
}
