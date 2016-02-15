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
    
    
    
    
    
    
    @IBAction func retweetButtonClicked(sender: AnyObject) {
        
        print("Retweet button clicked")
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        
        print("This is the index path of the cell: \(indexPath.row)")
        
        let tweet = tweets![indexPath.row]
        
        let tweetID = tweet.id
        
        TwitterClient.sharedInstance.retweetWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                print("Tweet was printed successfull.. incre tweet retweet count here")
                
                self.tweets![indexPath.row].retweetCount = self.tweets![indexPath.row].retweetCount as! Int + 1
                
                //  cell.retweetButton.setImage(UIImage(named: "retweet-clicked.png"), forState: UIControlState.Selected)
                
                
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
                
            }
            else {
                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
            }
        }
        

    }
    
    @IBAction func likeButtonClicked(sender: AnyObject) {
        
        print("Like button clicked")
        
        var button : UIButton = sender as! UIButton
        
       // button.setBackgroundImage(UIImage(named: "like-clicked"), forState: UIControlState.Highlighted)
        
        var subviewPostion: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        
        var indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(subviewPostion)!
        
        let cell =  self.tableView.cellForRowAtIndexPath(indexPath)! as! TweetCell
        
        print("This is the index path of the cell: \(indexPath.row)")
        
        let tweet = tweets![indexPath.row]
        
        let tweetID = tweet.id
        
        
        TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                print("Tweet was printed successfull.. incre tweet count here")
                
              //  cell.favButton.setImage(UIImage(named: "like-clicked.png"), forState: UIControlState.Selected)
                
               // self.tweets![indexPath.row] = tweet!
                self.tweets![indexPath.row].favCount = self.tweets![indexPath.row].favCount as! Int + 1
                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
                
            }
            else {
                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
            }
        }
        
    }
    
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        let tweet = tweets![indexPath.row]
    //
    //        let tweetID = tweet.id
    //
    //        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    //
    //
    //
    //        print("Cell selection detected")
    //
    //        TwitterClient.sharedInstance.retweetWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
    //
    //            if (tweet != nil) {
    //                print("Tweet was printed successfull.. incre tweet retweet count here")
    //
    //                print(tweet!.retweetCount as! Int)
    //                //
    //                //  cell.tweet = tweet
    //
    //                self.tweets![indexPath.row] = tweet!
    //
    //                //   print(tweet!.favCount as! Int)
    //                //   cell.favCountLabel.text = "\(tweet!.favCount as! Int)"
    //                // tableView.reloadData()
    //
    //                var indexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
    //                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    //
    //                //trying to reload data now
    //                //  self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
    //
    //            }
    //            else {
    //                print("Did it print the print fav tweet? cause this is the error message and you should not be seeing this.")
    //            }
    //        }
    //    }
    
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
