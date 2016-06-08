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
    
//  取得した記事の一覧を表示するテーブル
    @IBOutlet weak var qiitaView: UITableView!
//  表示する記事を保持
    var articles: [[String: String?]] = []
    var ref_articles: [[String: String?]] = []
    
//  取得したタグの一覧を保持
    var tags:[String] = []
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qiitaView.delegate = self
        qiitaView.dataSource = self
        
//      最新の記事データを取得
        articles = getArticles()
//      取得したデータを表示するために再描画
        self.qiitaView.reloadData()
        
//      タグ一覧を取得
        tags = getTags()
        print(tags)

        refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action:#selector(ViewController.refresh), forControlEvents:.ValueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        self.qiitaView.addSubview(refreshControl)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  ”下に引っ張って更新”の中身
    internal func refresh() {
        if self.ref_articles.count != 0 {
            self.ref_articles.removeAll()
        }
        self.ref_articles = refresh_articles()
        self.refreshControl.endRefreshing()
        if ref_articles.count != 0 {
            var cnt:Int = 0
            for article in self.ref_articles {
                self.articles.insert(article, atIndex: cnt)
                cnt += 1
            }
            self.qiitaView.reloadData()
        }
    }
    
    
//  表示するセルの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
//  セルに表示する内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = qiitaView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userID"]!
        return cell
    }
    
//  セルをタップした時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      セルの記事情報を取得
        let article = articles[indexPath.row]
//      タップしたらsafariでURL先を表示
        UIApplication.sharedApplication().openURL(NSURL(string:article["url"]!!)!)
    }
}

