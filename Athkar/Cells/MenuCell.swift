//
//  MenuCell.swift
//  Athkar
//
//  Created by binaryboy on 6/26/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet var menuNameLabel: UILabel!
    @IBOutlet var menuColorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
