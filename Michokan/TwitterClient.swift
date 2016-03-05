//
//  TwitterClient.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/6/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "bDSizjXcQz7FqseaZd4OCmCUc"
let twitterConsumerSecret = "JjrQIPoBlvZ7vh9XdcwuisWMc79Za2vZzQVjz3H49jczvwb8Jy"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)    
        }
        return Static.instance
    }
    
    func homeTimelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
           //   print("user_timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
           completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error)")
                completion(tweets: nil, error: error)
        })

    }
    
    func favoriteWithCompletion(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {

        POST("1.1/favorites/create.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweet = Tweet.tweetAsDictionary(response as! NSDictionary)
            
            print("This is the retweetCount: \(tweet.retweetCount)")
            print("This is the favCount: \(tweet.favCount)")

            completion(tweet: tweet, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("ERROR: \(error)")
                completion(tweet: nil, error: error)
        }
    }

    func retweetWithCompletion(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        POST("1.1/statuses/retweet/\(params!["id"] as! Int).json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweet = Tweet.tweetAsDictionary(response as! NSDictionary)
        
            print("This is the retweetCount: \(tweet.retweetCount)")
            print("This is the favCount: \(tweet.favCount)")

            //  print(tweet)
            
            completion(tweet: tweet, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("ERROR: \(error)")
                completion(tweet: nil, error: error)
        }
    }
    
    func unRetweetWithCompletion(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        
        POST("1.1/statuses/unretweet/\(params!["id"] as! Int).json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweet = Tweet.tweetAsDictionary(response as! NSDictionary)
            
        
            completion(tweet: tweet, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("ERROR: \(error)")
                completion(tweet: nil, error: error)
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //remove access token if it exist previously
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        //Getting the request token and redirect to authorization page
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "michokan://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            })
            { (error: NSError!) -> Void in
                print("Failed to get request token:  \(error)")
                self.loginCompletion?(user: nil, error: error)
        }
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    func openUrl(url: NSURL?) {
        
        //Get access token
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url!.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Access Token received")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(
                accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                //                print("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user.name = \(user.name)")
                self.loginCompletion!(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error: \(error)")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            })
            { (error: NSError!) -> Void in
                print("Access Token error")
                self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
}
