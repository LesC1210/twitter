//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func did(post: Tweet) {
        getTweets()
        print(post.text)
    }
    
    var tweets: [Tweet] = []
    var selectedTweet: Tweet?
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTweets(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        getTweets()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshTweets(_ refreshControl: UIRefreshControl) {
        getTweets()
        tableView.reloadData()
        refreshControl.endRefreshing()
        print("Refreshed")
    }
    
    func getTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                print("Actually Refreshed")
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        if (cell.tweet.favorited == true) {
            cell.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        if (cell.tweet.retweeted == true) {
            cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        cell.profilePictureImageView.layer.cornerRadius = cell.profilePictureImageView.frame.width / 2
        selectedTweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedTweet = tweets[indexPath.row]
        self.performSegue(withIdentifier: "tweetSegue", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tweetSegue") {
            let vc = segue.destination as! TweetViewController
            vc.tweet = selectedTweet
        }
        
        if (segue.identifier == "composeSegue") {
            let vc = segue.destination as! ComposeTweetViewController
            vc.delegate = (self as! ComposeViewControllerDelegate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem;        self.tabBarController?.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
