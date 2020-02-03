//
//  NowPalyingTableViewCell.swift
//  AppleMovie
//
//  Created by Captain on 13/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class NowPalyingTableViewCell: UITableViewCell {

    
    @IBOutlet var MovieImageView: UIImageView!
    @IBOutlet var moviename: UILabel!
    @IBOutlet var releasedlabel: UILabel!
    @IBOutlet var descriptionlabel: UILabel!
    @IBOutlet var ratinglabel: UILabel!
    @IBOutlet var votinglabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
