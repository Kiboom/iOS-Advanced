//
//  KeychainService.swift
//  Week 9-2 (Keychain)
//
//  Created by 김기범 on 2016. 8. 10..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit
import Security

let serviceIdentifier = "MySerivice2"
let userAccount = "authenticatedUser2"
let accessGroup = "MySerivice2"

let kSecClassValue = kSecClass as NSString
let kSecAttrAccountValue = kSecAttrAccount as NSString
let kSecValueDataValue = kSecValueData as NSString
let kSecClassGenericPasswordValue = kSecClassGenericPassword as NSString
let kSecAttrServiceValue = kSecAttrService as NSString
let kSecMatchLimitValue = kSecMatchLimit as NSString
let kSecReturnDataValue = kSecReturnData as NSString
let kSecMatchLimitOneValue = kSecMatchLimitOne as NSString


class KeychainService: NSObject {

    class func saveToken(data: NSData) {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, serviceIdentifier, userAccount, data], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        SecItemDelete(keychainQuery as CFDictionaryRef)
        SecItemAdd(keychainQuery as CFDictionaryRef, nil)
    }
    
    
    class func loadToken() -> NSData? {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, serviceIdentifier, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef: AnyObject?
        SecItemCopyMatching(keychainQuery, &dataTypeRef)
        return dataTypeRef as? NSData
    }
    
}
