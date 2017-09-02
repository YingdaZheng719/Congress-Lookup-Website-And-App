//
//  detailsTableViewCell.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/23/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailHeaderLabel: UILabel!
    @IBOutlet weak var detailContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
