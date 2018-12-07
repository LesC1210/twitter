//
//  TweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by user144860 on 10/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class TweetViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if self.tweet != nil{
            self.nameLabel.text = tweet!.user.name
            self.screenNameLabel.text = "@\(String(describing: tweet!.user.dictionary!["screen_name"]!))"
            self.tweetTextLabel.text = tweet!.text
            self.timestampLabel.text = tweet!.createdAtString
            self.retweetCountLabel.text = "\(String(describing: tweet!.retweetCount))"
            self.favoriteCountLabel.text = "\(tweet!.favoriteCount ?? 0)"
            self.profileImageView.af_setImage(withURL: URL(string: tweet!.user.dictionary?["profile_image_url_https"] as! String)!)
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            if (tweet!.favorited == true) {
                favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            if (tweet!.retweeted == true) {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
