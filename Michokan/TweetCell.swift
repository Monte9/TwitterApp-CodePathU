//
//  TweetCell.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/12/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import AFNetworking

protocol TweetCellDelegate: class {
    func retweetButtonClicked (tweetCell: TweetCell!)
    func likeButtonClicked (tweetCell: TweetCell!)
    func thumbImageClicked(tweetCell: TweetCell!)
}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var replyImageView: UIImageView!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    var buttonDelegate: TweetCellDelegate?
    
    var tweet : Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user?.name
            screennameLabel.text = "@\(tweet.user!.screenname)"
            
            retweetCountLabel.text = "\(tweet.retweetCount as! Int)"
            
            favCountLabel.text = "\(tweet.favCount as! Int)"
            
            profileImageView.setImageWithURL(tweet.user!.profileImageUrl!)
            
            timeLabel.text = calculateTimeStamp(tweet.createdAt!.timeIntervalSinceNow)
            
        }
    }
    
    //All credit for this method goes to David Wayman, slack @dwayman
    func calculateTimeStamp(timeTweetPostedAgo: NSTimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    
    @IBAction func retweetButtonClicked(sender: AnyObject) {
        print("Retweet button clicked")
        buttonDelegate?.retweetButtonClicked(self)
    }
    
    @IBAction func likeButtonClicked(sender: AnyObject) {
        print("Like button clicked")
        buttonDelegate?.likeButtonClicked(self)
    }
    
    @IBAction func profileImageClicked(sender: AnyObject) {
        print("Profile Image clicked")
        buttonDelegate?.thumbImageClicked(self)
    }
    
    
    
            
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
