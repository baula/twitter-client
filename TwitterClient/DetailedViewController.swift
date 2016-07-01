//
//  DetailedViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/29/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favoritesCounts: UILabel!
    @IBOutlet weak var retweetsCounts: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    var tw: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.text = tw.text
        favoritesCounts.text = "\(tw.favoritesCount)"
        retweetsCounts.text = "\(tw.retweetCount)"
        timestampLabel.text = "\(tw.timestamp!)"
        usernameLabel.text = tw.theUser?.name
        screennameLabel.text = "@\((tw.theUser?.screenname)!)"
        
        imageLabel.setImageWithURL((tw.theUser?.profileUrl)!)
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient1.sharedInstance.POST("1.1/favorites/create.json?id=\(tw.idstr!)", parameters: nil, success: nil, failure: nil)
        print("\(tw.idstr!)")
        tw.favoritesCount += 1
        self.favoritesCounts.text = "\(tw.favoritesCount)"
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient1.sharedInstance.POST("1.1/statuses/retweet/\(tw.idstr!).json", parameters: nil, success: nil, failure: nil)
        tw.retweetCount += 1
        self.retweetsCounts.text = "\(tw.retweetCount)"
    }
    
    @IBAction func onReply(sender: AnyObject) {
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
