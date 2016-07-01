//
//  PersonalViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 7/1/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user1: User!
    var tweets: [Tweet]! = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        
        TwitterClient1.sharedInstance.currentAccount({(user: User) -> () in
            self.user1 = user
            self.usernameLabel.text = self.user1.name
            self.taglineLabel.text = self.user1.tagline
            self.profilePic.setImageWithURL((self.user1.profileUrl)!)
            self.tweetCount.text = "\((self.user1.tweetCount)!)"
            self.screennameLabel.text = "@\((self.user1.screenname)!)"
            self.followingLabel.text = "\((self.user1.followingCount)!)"
            self.followerLabel.text = "\((self.user1.followerCount)!)"
            self.refresh()
            
            }, failure: { (error: NSError) in
                print(error.localizedDescription)
        })
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        TwitterClient1.sharedInstance.GET("1.1/statuses/user_timeline.json?user_id=\((self.user1!.userID)!)", parameters: nil , progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) ->Void in
            let dictionaries = response as! [NSDictionary]
            
            self.tweets = Tweet.tweetsWithArray(dictionaries)
            self.tableView.reloadData()
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) ->Void in
                
        })
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refresh()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonalCell", forIndexPath: indexPath) as! PersonalCell
        let row = indexPath.row
        let tw2 = tweets[row]
        
        cell.tweetLabel.text = tw2.text
        cell.favoritesCount.text = "\(tw2.favoritesCount)"
        cell.retweetsCount.text = "\(tw2.retweetCount)"
        cell.timestampLabel.text = "\(tw2.timeSince!)"
        cell.usernameLabel.text = tw2.theUser?.name
        
        
        cell.profilePics.setImageWithURL((tw2.theUser?.profileUrl)!)
        
        
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
