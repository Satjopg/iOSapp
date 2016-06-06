//
//  ViewController.swift
//  QiitaTestApp
//
//  Created by Satoru Murakami on 2016/05/31.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var qiitaView: UITableView!
    
    var articles: [[String: String?]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        qiitaView.delegate = self
        qiitaView.dataSource = self
        articles = getArticles()
        self.qiitaView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = qiitaView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userID"]!
        return cell
    }
}

