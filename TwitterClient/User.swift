//
//  User.swift
//  TwitterClient
//
//  Created by Baula Xu on 6/27/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary) {
        //print("name: \(user["name"])")
        //print("screenname: \(user["screen_name"])")
        //print("profile url: \(user["profile_image_url_https"])")
        //print("description: \(user["description"])")
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        tagline = dictionary["description"] as? String
    }

}