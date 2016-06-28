//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/28/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    //insert table view outlet
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient1.sharedInstance.homeTimeline({(tweets: [Tweet]) -> () in
            self.tweets = tweets
            //number of rows at index path, return self.tweets.count
//            for tweet in tweets{
//                print(tweet.text)
//                }
            
        //tableView.reloadData()
            
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
                
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient1.sharedInstance.logout()
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
