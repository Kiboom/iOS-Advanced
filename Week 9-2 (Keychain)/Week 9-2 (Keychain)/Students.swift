//
//  Students.swift
//  Week 9-2 (Keychain)
//
//  Created by 김기범 on 2016. 8. 10..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit



class Students: NSObject {
    private var info: Array = [[String:AnyObject]]()
    private let photos: Array = [UIImage.init(named: "무민.jpg"),
                                UIImage.init(named: "explosion.gif"),
                                UIImage.init(named: "몽키.png"),
                                UIImage.init(named: "오드리.jpg")]
    
    func addStudentInfo(id:String, name:String) {
        if Int(id) == nil {
            print("학번은 숫자만 입력 가능합니다!")
            return
        }
        self.info.append([
            "학번" : id,
            "이름" : name,
            "사진" : UIImagePNGRepresentation(self.photos[Int(arc4random_uniform(4))]!)!
            ])
    }
    
    /*
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
     */
    
    
    func getInfo() -> [[String:AnyObject]] {
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
        if(KeychainService.loadToken() == nil) {
            return
        }
        let xmlData: NSData = KeychainService.loadToken()!
        do{
            self.info = try NSPropertyListSerialization.propertyListWithData(xmlData, options:.MutableContainersAndLeaves, format: nil) as! [[String : AnyObject]]
        } catch {
            print(error)
            return
        }
    }
    
}
