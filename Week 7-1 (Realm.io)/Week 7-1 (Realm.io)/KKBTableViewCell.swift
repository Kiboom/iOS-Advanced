//
//  KKBTableViewCell.swift
//  Week 7-1 (Realm.io)
//
//  Created by 김기범 on 2016. 7. 27..
//  Copyright © 2016년 김기범. All rights reserved.
//

import UIKit

class KKBTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
