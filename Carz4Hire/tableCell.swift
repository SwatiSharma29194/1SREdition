//
//  tableCell.swift
//  Carz4Hire
//
//  Created by rv-apple on 15/03/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class tableCell: UITableViewCell {
 @IBOutlet var txt: UITextView!
    @IBOutlet var viewLine: UIView!
    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
