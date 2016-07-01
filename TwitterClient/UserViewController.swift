//
//  UserViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/30/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var tw: Tweet!
    var tweets: [Tweet]! = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        usernameLabel.text = tw.theUser?.name
        taglineLabel.text = tw.theUser?.tagline
        profilePic.setImageWithURL((tw.theUser?.profileUrl)!)
        tweetCountLabel.text = "\((tw.theUser?.tweetCount)!)"
        followingCountLabel.text = "\((tw.theUser?.followingCount)!)"
        followersCountLabel.text = "\((tw.theUser?.followerCount)!)"
        // Do any additional setup after loading the view.
        let refreshControl = UIRefreshControl()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        print((self.tw.theUser?.userID)!)
        TwitterClient1.sharedInstance.GET("1.1/statuses/user_timeline.json?user_id=\((self.tw.theUser?.userID)!)", parameters: nil , progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) ->Void in
            let dictionaries = response as! [NSDictionary]
            
            self.tweets = Tweet.tweetsWithArray(dictionaries)
            self.tableView.reloadData()
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) ->Void in
                
        })
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refresh()
        // Reload the tableView now that there is new data
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        let row = indexPath.row
        let tw2 = tweets[row]
        
        cell.TweetLabel.text = tw2.text
        cell.FavoritesCount.text = "\(tw2.favoritesCount)"
        cell.RetweetsCount.text = "\(tw2.retweetCount)"
        cell.timestampLabel.text = "\(tw2.timeSince!)"
        cell.usernameLabel.text = tw2.theUser?.name
        
        
        cell.profilePic.setImageWithURL((tw2.theUser?.profileUrl)!)
        
        
        //print("\(tw.text)")
        return cell
        
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
