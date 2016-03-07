//
//  TweetsViewController.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/9/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate {
    
    var tweets: [Tweet]?
    
    var tweetForSegue : Tweet?
    
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
        cell.buttonDelegate = self
        
        if (tweets != nil) {
            cell.tweet = tweets![indexPath.row]
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
        
    }
    
    func retweetButtonClicked (tweetCell: TweetCell!) {
        
        let tweet = tweetCell.tweet! as Tweet
        
        print("DO nothing")
        
        tweet.isRetweeted! ? (
            // It's been retweeted already... let's unretweet it:
            // YES! HASN'T BEEN RETWEETED, SO LET'S DO THAT:
            TwitterClient.sharedInstance.unRetweetWithCompletion(["id": tweet.id!]) { (tweet, error) -> () in
                
                if (tweet != nil) {
                    
                    print("Setting the button image")
                    
                    tweetCell.retweetButton.setImage(UIImage(named: "retweet-action_default.png"), forState: UIControlState.Selected)
                    
                    if tweetCell.retweetCountLabel.text! > "1" {
                        tweetCell.retweetCountLabel.text = String(tweet!.retweetCount! - 1)
                    } else {
                        tweetCell.retweetCountLabel.hidden = true
                        tweetCell.retweetCountLabel.text =
                            String(tweet!.retweetCount! - 1)
                    }
                    // locally update tweet dictionary so we don't need to make network request in order to update that cell
                    //                tweet!.retweetCount! += 1
                    tweet!.isRetweeted! = false
                }
                else {
                    print("ERROR retweeting: \(error)")
                }
            }

            ) : (
        
        
        // YES! HASN'T BEEN RETWEETED, SO LET'S DO THAT:
        TwitterClient.sharedInstance.retweetWithCompletion(["id": tweet.id!]) { (tweet, error) -> () in
            
            if (tweet != nil) {
                
                print("Setting the button image")
                
                tweetCell.retweetButton.setImage(UIImage(named: "retweet-action-on-green.png"), forState: UIControlState.Selected)
                
                if tweetCell.retweetCountLabel.text! > "0" {
                    tweetCell.retweetCountLabel.text = String(tweet!.retweetCount! + 1)
                } else {
                    tweetCell.retweetCountLabel.hidden = false
                    tweetCell.retweetCountLabel.text =
                        String(tweet!.retweetCount! + 1)
                }
                // locally update tweet dictionary so we don't need to make network request in order to update that cell
//                tweet!.retweetCount! += 1
                tweet!.isRetweeted! = true
            }
            else {
                print("ERROR retweeting: \(error)")
            }
        }
        
        )
        
    }
    
    func thumbImageClicked (tweetCell: TweetCell!) {
       
       tweetForSegue = tweetCell.tweet! as Tweet
        
        performSegueWithIdentifier("profileSegue", sender: self)
    }
    

    
    
    func likeButtonClicked (tweetCell: TweetCell!) {
        //        TwitterClient.sharedInstance.favoriteWithCompletion(["id": tweetID!]) { (tweet, error) -> () in
        //
        //            if (tweet != nil) {
        //
        //                self.favButton.setImage(UIImage(named: "like-action-on-red.png"), forState: UIControlState.Normal)
        //
        //                if self.favCountLabel.text! > "0" {
        //                    self.favCountLabel.text = String(self.tweet.favCount! + 1)
        //                } else {
        //                    self.favCountLabel.hidden = false
        //                    self.favCountLabel.text = String(self.tweet.favCount! + 1)
        //                }
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "profileSegue" {
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.tweet = tweetForSegue
        } else if segue.identifier == "tweetSegue" {
            
            print(sender)
            
            let cell = sender as! TweetCell
            
            let indexPath = tableView.indexPathForCell(cell)
            let newTweet = tweets![indexPath!.row]
            
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = newTweet
        }
    
        
        print("Tweet set successfully for segue")
    }
    
    
}
