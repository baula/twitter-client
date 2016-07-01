//
//  UserCell.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/30/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var TweetLabel: UILabel!
    @IBOutlet weak var FavoritesCount: UILabel!
    @IBOutlet weak var RetweetsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
