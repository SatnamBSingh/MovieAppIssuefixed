//
//  ShowAllTableViewCell.swift
//  AppleMovie
//
//  Created by Captain on 12/02/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit

class ShowAllTableViewCell: UITableViewCell {

    
    @IBOutlet weak var showallImage: UIImageView!
    @IBOutlet weak var showAllMoviename: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
