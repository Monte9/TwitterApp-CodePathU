//
//  TweetCell.swift
//  Michokan
//
//  Created by Monte's Pro 13" on 2/12/16.
//  Copyright © 2016 MonteThakkar. All rights reserved.
//

import UIKit
import AFNetworking

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
    
    var tweet : Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user?.name
            screennameLabel.text = "@\(tweet.user!.screenname)"

            retweetCountLabel.text = "\(tweet.retweetCount as! Int)"
            print("This set the retweet count: \(tweet.retweetCount as! Int)")
            
            favCountLabel.text = "\(tweet.favCount as! Int)"
            print("This is the set fav count: \(tweet.favCount as! Int)")
            
            if (tweet.user?.profileImageUrl != nil) {
            //    profileImageView.setImageWithURL(tweet.user!.profileImageUrl)
            } else {
                print("No profile picture found")
            }
            
            replyImageView.image = UIImage(named: "reply-blue")
            
            retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            
            favButton.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            
            
         //   retweetImageView.image = UIImage(named: "retweet-blue")
          //  likeImageView.image = UIImage(named: "like-blue")
          //  timeLabel.text = "\(tweet.createdAt)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
