//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/28/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var tableView: UITableView!
    //insert table view outlet
    var tweets: [Tweet]! = []

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        
        
        let refreshControl = UIRefreshControl()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        refresh()
        
        // Do any additional setup after loading the view.
        //self.tableView.reloadData()
    }
    
    func refresh(){
        TwitterClient1.sharedInstance.homeTimeline({(tweets: [Tweet]) -> () in
            self.tweets = tweets
            //number of rows at index path, return self.tweets.count
            //            for tweet in tweets{
            //                print(tweet.text)
            //                }
            
            
            self.tableView.reloadData()
            
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
                
        })

    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        refresh()
        // Reload the tableView now that there is new data
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient1.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let row = indexPath.row
        let tw = tweets[row]

        cell.tw = tw
        cell.tweetLabel.text = tw.text
        cell.favoriteCount.text = "\(tw.favoritesCount)"
        cell.retweetCount.text = "\(tw.retweetCount)"
        cell.timestampLabel.text = "\(tw.timeSince!)"
        cell.usernameLabel.text = tw.theUser?.name
        
        
        cell.profilePic.setImageWithURL((tw.theUser?.profileUrl)!)
        
        
        //print("\(tw.text)")
        return cell

            }

    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UITableViewCell {
            
            let indexPath = tableView.indexPathForCell(cell)
            let posts = tweets[indexPath!.row]
            
            
            if segue.identifier == "detailedSegue"{
                let detailViewController = segue.destinationViewController as! DetailedViewController
                detailViewController.tw = posts
            }
        }
        
        
        if segue.identifier == "userSegue"{
            let button = sender as! UIButton
            let cell = button.superview!.superview as! TweetCell
            let userViewController = segue.destinationViewController as! UserViewController
            userViewController.tw = cell.tw
        }

}
    

}
