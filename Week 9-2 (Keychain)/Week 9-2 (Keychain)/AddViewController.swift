//
//  AddViewController.swift
//  Week 9-2 (Keychain)
//
//  Created by 김기범 on 2016. 8. 10..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var students: Students?
    @IBOutlet var nameField: UITextField!
    @IBOutlet var numberField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OK(sender: AnyObject) {
        students?.addStudentInfo(self.numberField.text!, name: self.nameField.text!)
        students?.saveInfoToKeychain()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
