//
//  UserViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/30/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class UserViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
   // @IBOutlet weak var tableView: UITableView!
    
    
    var tw: Tweet!
    
    override func viewDidLoad() {
        //tableView.dataSource = self
        //tableView.delegate = self
        super.viewDidLoad()
        usernameLabel.text = tw.theUser?.name
        taglineLabel.text = tw.theUser?.tagline
        profilePic.setImageWithURL((tw.theUser?.profileUrl)!)
        tweetCountLabel.text = "\((tw.theUser?.tweetCount)!)"
        followingCountLabel.text = "\((tw.theUser?.followingCount)!)"
        followersCountLabel.text = "\((tw.theUser?.followerCount)!)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
