//
//  TwitterClient1.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/28/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient1: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient1(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "VKnRhPLbRkGRBRSqbpJYpgbxf", consumerSecret: "29t9aoYOUKX8QGXTja7GtGGwDkHKF1vhr2hhml9nlbZwwVmHoK")
    
    var loginSuccess:(()->())?
    var loginFailure:((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient1.sharedInstance.deauthorize()
        TwitterClient1.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterclient://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("I got a token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (acesssToken:BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error :NSError) in
                    self.loginFailure?(error)
            })
            
            
            print("I got the access token")
            self.loginSuccess?()
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) ->Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) ->Void in
            failure(error)
                
        })
        
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response:AnyObject?) ->Void in
            //print ("account:\(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            print("name: \(user.name)")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) ->Void in
                failure(error)
        })

    }
}