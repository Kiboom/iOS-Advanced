//
//  TodayViewController.swift
//  Today
//
//  Created by 김기범 on 2016. 7. 20..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    var userDefaults: NSUserDefaults = NSUserDefaults.init(suiteName: "group.org.nhnnext.kiboom")!
    @IBOutlet var dDayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        update()
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("뷰 윌 디써피어")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("뷰 디드 디써피어")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func update() {
        guard let dDay = userDefaults.stringForKey("dDay") else {
            dDayLabel.text = "앱에서 날짜를 설정하세요"
            return
        }
        dDayLabel.text = dDay
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.NewData)
    }
    
}
