//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Cam Tran on 4/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1

    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
            if(toBeFavorited){
                TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                    self.setFavorite(true)
                }, failure: { (error) in
                    print("Favorite did not suceeed: \(error)")
                })
            } else {
                TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                    self.setFavorite(false)
                }, failure:{ (error) in
                print("unfavorite did not suceeed: \(error)")
                })
            }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(_isRetweeted: true)
        }, failure: { (error) in
            print("Error in retweeting \(error)")
        })
        
    }
    func setRetweeted( _isRetweeted:Bool){
        if(_isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
