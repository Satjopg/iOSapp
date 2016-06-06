//
//  QiitaData.swift
//  QiitaTestApp
//
//  Created by Satoru Murakami on 2016/06/04.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//最新記事を取得する
func getArticles() -> [[String: String?]] {
//  記事を保持するようの変数とresponceの状態を保持する変数を用意
    var keep:Bool = true
    var articles: [[String: String?]] = []
//    以下、記事取得
        Alamofire.request(.GET, "https://qiita.com/api/v2/items")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json_data = JSON(object)
                json_data.forEach{ (_, json_data) in
                    let article: [String:String?] = [
                        "title":json_data["title"].string,
                        "userID":json_data["user"]["id"].string
                    ]
                    articles.append(article)
                }
                keep = false
        }
    let runloop = NSRunLoop.currentRunLoop()
    while keep && runloop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {
//        0.1秒ごとに変数チェック
//        response処理待ち
    }
    return articles
}