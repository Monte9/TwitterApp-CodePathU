//
//  Tweet.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/9/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: NSNumber?
    var favCount: NSNumber?
    var retweetCount: NSNumber?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
    //    print("This is the user: \(user)")
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        id = dictionary["id"] as? Int
       // print("This is the tweet id: \(id)")
        
       // print(dictionary["favorite_count"] as? Int)

        
        favCount = dictionary["favorite_count"] as! Int

      //  print(favCount)
        
        retweetCount = dictionary["retweet_count"] as? Int
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
    }
    
    
    //convinience method that takes array of dictionaries and returns array of tweets
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
           // print(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    //convinience method that takes array of dictionaries and returns array of tweets
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
       // print(dict)
        
        var tweet = Tweet(dictionary: dict)
        
        return tweet
    }
    
    
}
