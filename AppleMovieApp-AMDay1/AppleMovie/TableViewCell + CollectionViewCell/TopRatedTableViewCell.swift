//
//  TopRatedTableViewCell.swift
//  AppleMovie
//
//  Created by Captain on 15/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {

    
    @IBOutlet var MVImageView: UIImageView!
    @IBOutlet var movienamelbl: UILabel!
    @IBOutlet var releaseddatelbl: UILabel!
    @IBOutlet var popularitylbl: UILabel!
    @IBOutlet var votecountlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
