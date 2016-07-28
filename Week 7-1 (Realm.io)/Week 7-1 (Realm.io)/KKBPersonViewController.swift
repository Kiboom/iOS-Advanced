//
//  KKBPersonViewController.swift
//  Week 7-1 (Realm.io)
//
//  Created by 김기범 on 2016. 7. 27..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit
import RealmSwift

class KKBPersonViewController: UIViewController {

    var age: Int = 0
    var name: String = ""
    let realm = try! Realm()
    
    var personToEdit: KKBPerson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nameChanged(sender: UITextField) {
        self.name = sender.text!
    }

    @IBAction func ageChanged(sender: UITextField) {
        if Int(sender.text!) == nil {
            return
        }
        self.age = Int(sender.text!)!
    }

    func insertData() {
        let newPerson: KKBPerson = KKBPerson()
        newPerson.age = self.age
        newPerson.name = self.name
        try! realm.write {
            realm.add(newPerson)
        }
    }
    
    func updateData() {
        try! realm.write {
            personToEdit!.age = age
            personToEdit!.name = name
            personToEdit = nil
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if self.personToEdit != nil {
            updateData()
        } else {
            insertData()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
