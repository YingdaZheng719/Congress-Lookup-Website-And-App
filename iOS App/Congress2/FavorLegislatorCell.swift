//
//  FavorLegislatorCell.swift
//  Congress2
//
//  Created by Yingda Zheng on 11/27/16.
//  Copyright © 2016 Yingda Zheng. All rights reserved.
//

import UIKit

class FavorLegislatorCell: UITableViewCell {

    @IBOutlet weak var legislatorImage: UIImageView!
    @IBOutlet weak var legislatorFirstNameLabel: UILabel!
    @IBOutlet weak var legislatorLastNameLabel: UILabel!
    @IBOutlet weak var legislatorStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
