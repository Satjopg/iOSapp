//
//  ViewController.swift
//  QiitaTestApp
//
//  Created by Satoru Murakami on 2016/05/31.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
//  取得した記事の一覧を表示するテーブル
    @IBOutlet weak var qiitaView: UITableView!
//  表示する記事を保持
    var articles: [[String: String?]] = []
//  更新記事を保持
    var ref_articles: [[String: String?]] = []
//  更新動作のモデル
    var refreshControl:UIRefreshControl!
//  タグを保持する
    var tags:[[String:String?]] = []
//  一度ダウンロードした画像を保存しておく
    var icon_Cache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qiitaView.delegate = self
        qiitaView.dataSource = self
        
//      セルの大きさを可変にする
        qiitaView.estimatedRowHeight = 80
        qiitaView.rowHeight = UITableViewAutomaticDimension

//      最新の記事データを取得
        articles = getArticles()
//      取得したデータを表示するために再描画
        self.qiitaView.reloadData()
        
//      タグ一覧取得
        tags = getTags()
//      遷移先に戻るボタンを追加
        add_BackBtn()
//      記事更新機能を追加(うまくいかない...)
//        refresh_control()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//  更新動作を追加する
    func refresh_control() {
//      ”下に引っ張ると更新”の宣言
        refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action:#selector(ViewController.refresh), forControlEvents:.ValueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        self.qiitaView.addSubview(refreshControl)
    }
    
//  ”下に引っ張ると更新”の中身
    internal func refresh() {
//      中身があったら全部削除
        if self.ref_articles.count != 0 {
            self.ref_articles.removeAll()
        }
//      更新記事を読み込む
        self.ref_articles = refresh_articles()
//      ”ぐるぐる”停止
        self.refreshControl.endRefreshing()
//      更新記事があれば一番上に表示するように挿入して、tableを再描画
        if ref_articles.count != 0 {
            var cnt:Int = 0
            for article in self.ref_articles {
                self.articles.insert(article, atIndex: cnt)
                cnt += 1
            }
            self.qiitaView.reloadData()
        }
    }
    
//  サーチボタンをおした時の動作
//  画面を遷移するだけなので中身はいらない
    @IBAction func tapSearchButton(sender: UIBarButtonItem) {
    }
    
//  遷移先に戻るボタンを追加する
    func add_BackBtn() {
//      戻るボタンの設定（遷移先に表示される）
        let backbtn = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backbtn
    }
    
    
/* 以下、セルの設定 */
    
    
//  表示するセルの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
//  セルに表示する内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ArticleCell = qiitaView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleCell
        let article = self.articles[indexPath.row]
        let up_date = purse_date(article["date"]!!)
        if icon_Cache.objectForKey(article["image"]!!) == nil {
            let data:NSData = get_icon(article["image"]!!)
            icon_Cache.setObject(data, forKey: article["image"]!!)
        }
        dispatch_async(dispatch_get_main_queue()) { () in
            cell.icon.image = UIImage(data: self.icon_Cache.objectForKey(article["image"]!!) as! NSData)
        }
        cell.article.text = article["title"]!
        cell.userID.text = "@"+article["userID"]!!
        cell.upDate.text = up_date
        cell.layoutIfNeeded()
        return cell
    }
    
//  セルをタップした時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//      セルの記事情報を取得
        let article = articles[indexPath.row]
//      タップしたらsafariでURL先を表示
        UIApplication.sharedApplication().openURL(NSURL(string:article["url"]!!)!)
    }
    
/* おしまい */
    
//  日時の情報を見やすくするためにパースする
    internal func purse_date(date:String) -> String{
        return ((date as NSString).substringWithRange(NSMakeRange(5, 5))) + " " + ((date as NSString).substringWithRange(NSMakeRange(11, 5)))
    }
    
    
//  画面遷移時の動作（今回は値の受け渡し）  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextView = segue.destinationViewController as! SearchViewController
        nextView.tags = self.tags
    }
}

