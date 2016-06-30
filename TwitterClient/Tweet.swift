//
//  Tweet.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/27/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var theUser: User?
    var idstr: Int?
    var timeSince: String?
    
    init(dictionary: NSDictionary) {
        idstr = dictionary["id"] as? Int
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        theUser = User(dictionary: dictionary["user"] as! NSDictionary)
        //timestamp?.relativeTime = dictionary["created_at"]
        
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "E MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            timeSince = timestamp?.relativeTime
            
        }
        
 
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary])-> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
