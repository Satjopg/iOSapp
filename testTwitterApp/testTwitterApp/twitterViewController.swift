//
//  twitterViewController.swift
//  testTwitterApp
//
//  Created by Satoru Murakami on 2016/03/10.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import Social

class twitterViewController: UITableViewController {

    @IBAction func pushTweet(sender: AnyObject) {
        let tweetView:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        self.presentViewController(tweetView, animated: true, completion: nil)
        tweetView.setInitialText("わいのアプリから送信")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
