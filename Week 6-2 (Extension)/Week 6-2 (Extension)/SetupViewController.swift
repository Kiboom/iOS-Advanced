//
//  SetupViewController.swift
//  Week 6-2 (Extension)
//
//  Created by 김기범 on 2016. 7. 20..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    var prevViewController: ViewController?
    var date: NSDate = NSDate.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        date = sender.date
    }
    
    @IBAction func done(sender: AnyObject) {
        prevViewController?.chosenDate = date
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
