//
//  ResultViewController.swift
//  QiitaTestApp
//
//  Created by Satoru Murakami on 2016/06/09.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var view_title:String = ""
    var tag_articles: [[String:String?]] = []
    @IBOutlet weak var searchResultTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.view_title
        self.searchResultTable.estimatedRowHeight = 80
        self.searchResultTable.rowHeight = UITableViewAutomaticDimension
        self.tag_articles = search_Articles(view_title)
        self.searchResultTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
/* セルの設定 */
    
//  表示するセルの個数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tag_articles.count
    }
    
//  セルに表示するもの等の設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SearchArticleCell = self.searchResultTable.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as! SearchArticleCell
        let article = self.tag_articles[indexPath.row]
        let up_date = ViewController().purse_date(article["date"]!!)
        cell.article.text = article["title"]!
        cell.userID.text = article["userID"]!
        cell.update.text = up_date
        return cell
    }
    
//  セルをタップした時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      セルの記事情報を取得
        let article = tag_articles[indexPath.row]
//      タップしたらsafariでURL先を表示
        UIApplication.sharedApplication().openURL(NSURL(string:article["url"]!!)!)
    }
    
/* おしまい */
    
}
