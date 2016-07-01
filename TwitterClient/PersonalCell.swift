//
//  PersonalCell.swift
//  TwitterClient
//
//  Created by Baula Xu on 7/1/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class PersonalCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetsCount: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var profilePics: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
