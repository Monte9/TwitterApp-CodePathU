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
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)    
        }
        return Static.instance
    }
    
}
