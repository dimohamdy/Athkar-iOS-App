//
//  PageCell.swift
//  Athkar
//
//  Created by binaryboy on 6/28/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class PageCell: UITableViewCell {
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
