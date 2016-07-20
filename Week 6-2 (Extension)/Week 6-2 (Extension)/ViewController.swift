//
//  ViewController.swift
//  Week 6-2 (Extension)
//
//  Created by 김기범 on 2016. 7. 20..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dDay: Int = 0
    var chosenDate: NSDate?
    let userDefaults: NSUserDefaults = NSUserDefaults.init(suiteName: "group.org.nhnnext.kiboom")!
    @IBOutlet var dDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        if (chosenDate) != nil {
            self.updateDDay()
        }
    }
    
    func updateDDay() {
        let calendar = NSCalendar.currentCalendar()
        let difference = calendar.components(.Day, fromDate: chosenDate!, toDate: NSDate.init(), options: [])
        dDay = difference.day
        if dDay == 0 {
            dDayLabel.text = "D-Day!"
        } else {
            dDayLabel.text = ((dDay>0) ? "+":"") + dDay.description + ((dDay==1) ? " Day":" Days")
        }
        userDefaults.setObject(dDayLabel.text, forKey: "dDay")
        userDefaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let setupViewController: SetupViewController = segue.destinationViewController as! SetupViewController
        setupViewController.prevViewController = self
    }

}

