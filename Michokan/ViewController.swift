//
//  ViewController.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/6/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        
        //Getting the access token for signin
        //remove access token if it exist previously
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
      //  let serializeRequest : AFJSONRequestSerializer = AFJSONRequestSerializer(0)
       // TwitterClient.sharedInstance.requestSerializer = AFJSONRequestSerializer()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "michokan://outh"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got request token")
            }) { (error: NSError!) -> Void in
                print("ERROR:  \(error)")
        }
        
        
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }

}

