//
//  Students.swift
//  Week 9-2 (Keychain)
//
//  Created by 김기범 on 2016. 8. 10..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit



class Students: NSObject {
    private var info: Dictionary = [String:String]()
    
    func addStudentInfo(id:String, name:String) {
        if Int(id) == nil {
            print("학번은 숫자만 입력 가능합니다!")
            return
        }
        self.info[id] = name
    }
    
    
    func removeStudentInfo(id:String) {
        if Int(id) == nil {
            print("학번은 숫자만 입력 가능합니다!")
            return
        }
        self.info.removeValueForKey(id)
    }
    
    
    func updateStudentInfo(id:String, name:String) {
        guard Int(id) != nil else {
            print("학번은 숫자만 입력 가능합니다!")
            return
        }
        self.info[id] = name
    }
    
    
    func getInfo() -> [String:String] {
        return self.info
    }
    
    
    func saveInfoToKeychain() {
        var xmlData:NSData
        do {
            xmlData = try NSPropertyListSerialization.dataWithPropertyList(self.info, format:.XMLFormat_v1_0, options: 0)
        } catch {
            print(error)
            return
        }
        KeychainService.saveToken(xmlData)
    }
    
    
    func loadInfoFromKeychain() {
        let xmlData: NSData = KeychainService.loadToken()!
        do{
            self.info = try NSPropertyListSerialization.propertyListWithData(xmlData, options:.MutableContainersAndLeaves, format: nil) as! [String : String]
        } catch {
            print(error)
            return
        }
    }
    
}
