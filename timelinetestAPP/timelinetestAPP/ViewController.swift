//
//  ViewController.swift
//  timelinetestAPP
//
//  Created by Satoru Murakami on 2016/03/16.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import Social
import Accounts

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var accountStore:ACAccountStore = ACAccountStore()
    var twAccount: ACAccount?
    var tweets:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAccounts()
        
        self.table.estimatedRowHeight = 90
        table.rowHeight = UITableViewAutomaticDimension
        table.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // ios機器に登録されたアカウントを取得するメソッド
    func getAccounts() {
        // アカウントの種類を決める（ex:facebook）。今回はtwitterなのでそれを選択
        let accountType:ACAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        // アカウントの取得を行う
        accountStore.requestAccessToAccountsWithType(accountType, options: nil){ (granted: Bool, error: NSError?) -> Void in
            if error != nil {
                print("error! \(error)")
                return
            }
            
            if !granted {
                print("error! Twitterアカウントの利用が許可されていません")
                return
            }
            // accountsに取得したアカウントが入る
            let accounts = self.accountStore.accountsWithAccountType(accountType) as! [ACAccount]
            //
            if accounts.count == 0 {
                print("error! 設定画面からアカウントを設定してください")
                return
            }
            
            print("アカウント取得完了")
            
            // アクションシートに取得したアカウントを表示
            self.showAccountSelectSheet(accounts)
        }
    }
    
    // アカウント選択のActionSheetを表示する
    private func showAccountSelectSheet(accounts: [ACAccount]) {
        
        let alert = UIAlertController(title: "Twitter",
            message: "アカウントを選択してください",
            preferredStyle: .ActionSheet)
        
        // アカウント選択のActionSheetを表示するボタン
        for account in accounts {
            alert.addAction(UIAlertAction(title: account.username,
                style: .Default,
                handler: { (action) -> Void in
                    // twaccountに選択したアカウントを保持させる
                    print("your select account is \(account)")
                    self.twAccount = account
                    self.getTimeline()
            }))
        }
        
        // キャンセルボタン
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        // 表示する
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // 右上のボタンを押すことでツイート作成画面を表示する
    // tweetの送信（アカウントを選んで文をツイートできる）
    // 画像の送信等は対応していない
    @IBAction func tweetbutton(sender: AnyObject) {
        // tweet送信画面を作成
        let tweetView:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        // 送信画面を現在の画面に表示する
        self.presentViewController(tweetView, animated: true, completion: nil)
        // 予め文字を書き込む（任意）
        tweetView.setInitialText("わいのアプリから送信")
    }
    
    // 表示するセルの個数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
     return self.tweets.count
    }
    
    // 各セルの要素を決定する
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell:TweetViewCell = (self.table.dequeueReusableCellWithIdentifier("tweetcell", forIndexPath: indexPath) as? TweetViewCell)!
        
        let tweet:AnyObject = self.tweets[indexPath.row]
        let user:AnyObject? = tweet.objectForKey("user")
        
        cell.name.text = user?.objectForKey("name") as! NSString as String
        cell.account.text = "@" + (user?.objectForKey("screen_name") as! NSString as String)
        cell.tweet.text = tweet["text"] as! NSString as String
        
        cell.layoutIfNeeded()
        
        return cell
    }

    // タイムラインを取得
    private func getTimeline() {
        // ホームタイムラインを取得するURL
        let URL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        // リクエスト情報を生成
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            URL: URL,
            parameters: nil)
        
        // 認証したアカウントをセット
        request.account = twAccount
        
        // APIコールを実行
        request.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
            
            if error != nil {
                print("error is \(error)")
            }
            else {
                
                // 結果の表示
                self.tweets = try! NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments) as! [AnyObject]
                print("\(self.tweets)")
                
                // tableViewを更新
                dispatch_async(dispatch_get_main_queue()) {
                self.table.reloadData()
                }
            }
        }
    }
}

