//
//  HouseCommitteesTableViewCell.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/26/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit

class HouseCommitteesTableViewCell: UITableViewCell {

    @IBOutlet weak var committeeNameLabel: UILabel!
    @IBOutlet weak var committeeIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
