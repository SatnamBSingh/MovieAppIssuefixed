//
//  SearchTableViewCell.swift
//  AppleMovie
//
//  Created by Captain on 17/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var serachimgvw1: UIImageView!
    @IBOutlet var searchmovinmae: UILabel!
    @IBOutlet var searchreleasedlbl: UILabel!
    @IBOutlet var searchpopularitylbl: UILabel!
    @IBOutlet var searchvotecnt: UILabel!
    @IBOutlet var serachimgvw2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
