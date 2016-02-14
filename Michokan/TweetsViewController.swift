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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tweet = tweets![indexPath.row]
        
        let tweetID = tweet.id
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        
        
        print("Cell selection detected")
        
        TwitterClient.sharedInstance.retweetWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                print("Tweet was printed successfull.. incre tweet retweet count here")
                
                print(tweet!.retweetCount as! Int)
                //
                //  cell.tweet = tweet
                
                self.tweets![indexPath.row] = tweet!
                
                //   print(tweet!.favCount as! Int)
                //   cell.favCountLabel.text = "\(tweet!.favCount as! Int)"
                // tableView.reloadData()
                
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
                
                //trying to reload data now
                //  self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
                
            }
            else {
                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
            }
        }
        
        
        
       // print("This is the old fav count: \(tweet.favCount as! Int)")
        
//        TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
//            
//            if (tweet != nil) {
//                print("Tweet was printed successfull.. incre tweet count here")
//                
//                print(tweet!.favCount as! Int)
//             //
//              //  cell.tweet = tweet
//                
//                self.tweets![indexPath.row] = tweet!
//                
//             //   print(tweet!.favCount as! Int)
//             //   cell.favCountLabel.text = "\(tweet!.favCount as! Int)"
//               // tableView.reloadData()
//                
//                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
//                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
//                
//              //trying to reload data now
//              //  self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
//                
//            }
//            else {
//                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
//            }
//        }
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
