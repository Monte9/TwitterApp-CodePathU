//
//  TweetsViewController.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/9/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate =  self
        tableView.dataSource = self
        
        //set tableviewcell row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil) { (tweets, error) -> () in
            
            if (tweets != nil) {
                self.tweets = tweets
                self.tableView.reloadData()
            }
            
//            for tweet in tweets! {
//                //print(tweet)
//                print("\(tweet.text)")
////                self.textLabel.text = tweet.text
////                self.nameLabel.text = tweet.user?.name
////                self.screennameLabel.text = tweet.user?.screenname
//            //    self.profileImageView.setImageWithURL(tweet.user?.profileImageUrl)
//            }
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        if (tweets != nil) {
            cell.tweet = tweets![indexPath.row]
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
