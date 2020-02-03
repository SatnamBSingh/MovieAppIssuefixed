//
//  UpcomingTableViewCell.swift
//  AppleMovie
//
//  Created by Captain on 15/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    
    @IBOutlet var upcomingImgView: UIImageView!
    @IBOutlet var mvnameUpcm: UILabel!
    @IBOutlet var releasedateupcm: UILabel!
    @IBOutlet var popularityupcm: UILabel!
    @IBOutlet var votecountupcm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
