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
    
    @IBOutlet weak var retweetImageView: UIImageView!
    
    @IBOutlet weak var likeImageView: UIImageView!
    
    var tweet : Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user?.name
            screennameLabel.text = "@\(tweet.user!.screenname)"

            
            
            if (tweet.user?.profileImageUrl != nil) {
            //    profileImageView.setImageWithURL(tweet.user!.profileImageUrl)
            } else {
                print("No profile picture found")
            }
            
            replyImageView.image = UIImage(named: "reply-blue")
            retweetImageView.image = UIImage(named: "retweet-blue")
            likeImageView.image = UIImage(named: "like-blue")
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
