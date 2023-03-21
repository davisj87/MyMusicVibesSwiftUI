//
//  KeychainHelper.swift
//  My Music Vibes
//
//  Created by Jarred Davis on 3/7/23.
//

import Foundation

final class KeychainHelper {
    static let tokenSeviceStr: String = "access-token"
    static let refreshSeviceStr: String = "refresh_token"
    private static let accountStr: String = "MySongComparison"
    static let standard = KeychainHelper()
    private init() {}
    
    func save(_ data: Data, service: String) {

        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.accountStr,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        // Add data in query to keychain
        let status = SecItemAdd(query, nil)

        if status == errSecDuplicateItem {
            // Item already exists, update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: KeychainHelper.accountStr,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func read(service: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.accountStr,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(service: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: KeychainHelper.accountStr,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
}

extension KeychainHelper {
    
    func save<T>(_ item: T, service: String) where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, service: service)
            
        } catch {
            assertionFailure("Failed to encode item for keychain: \(error)")
        }
    }
    
    func read<T>(service: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(service: service) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Failed to decode item for keychain: \(error)")
            return nil
        }
    }
    
}
