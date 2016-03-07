//
//  User.swift
//  Twitter
//
//  Created by Tejen Hasmukh Patel on 2/7/16.
//  Copyright © 2016 Tejen. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCuurentUserKey";
let userDidLoginNotification = "userDidLoginNotification";
let userDidLogoutNotification = "userDidLogoutNotification";

class User: NSObject {
    var name: String?;
    var screenname: String!;
    var profileImageUrl: NSURL?;
    var tagline: String?;
    var dictionary: NSDictionary;
    var profileBackgroundImageUrl: NSURL?
    var numFollowers: Int?
    var numFollowing: Int?
    var numTweets: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary;
        
        name = dictionary["name"] as? String;
        screenname = dictionary["screen_name"] as? String;
        
        numFollowers = dictionary["followers_count"] as? Int
        numFollowing = dictionary["friends_count"] as? Int
        numTweets = dictionary["statuses_count"] as? Int
        
        let imageURLString = dictionary["profile_image_url"] as? String
        if imageURLString != nil {
            profileImageUrl = NSURL(string: imageURLString!)!
        }
        
        let backgroundImageURLString = dictionary["profile_background_image_url_https"] as? String
        if backgroundImageURLString != nil {
            profileBackgroundImageUrl = NSURL(string: backgroundImageURLString!)!
        }


        tagline = dictionary["description"] as? String;
    }
    
    func logout() {
        print(User.currentUser)
        User.currentUser = nil;
        print(User.currentUser)
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken();
        print("is this getting called?")
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil);
    }
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData;
        if data != nil {
        do {
        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions());
        _currentUser = User(dictionary: dictionary as! NSDictionary);
    } catch _ {
        
        }
        }
        }
        return _currentUser;
        }
        set(user) {
            _currentUser = user;
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions());
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey);
                } catch _ {
                    
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey);
            }
            NSUserDefaults.standardUserDefaults().synchronize();
        }
    }
}