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
        Alamofire.request(.GET, "https://qiita.com/api/v2/items?per_page=40")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json_data = JSON(object)
                json_data.forEach{ (_, json_data) in
                    let article: [String:String?] = [
                        "title":json_data["title"].string,
                        "userID":json_data["user"]["id"].string,
                        "url":json_data["url"].string
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

func getTags() -> [String]{
//  タグ一覧を保持する
    var tags:[String] = []
//  待機か、実行状態をコントロールする変数
    var keep:Bool = true
//  以下、タグ一覧取得
    Alamofire.request(.GET, "https://qiita.com/api/v2/tags?sort=count&per_page=40")
    .responseJSON { response in
        guard let object = response.result.value else {
            return
        }
        let json_data = JSON(object)
        json_data.forEach{ (_, json_data) in
            let tag:String = json_data["id"].string!
            tags.append(tag)
        }
        keep = false
    }
    
    let runloop = NSRunLoop.currentRunLoop()
    while keep && runloop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {
        //        0.1秒ごとに変数チェック
        //        response処理待ち
    }
    return tags
}

func refresh_articles() -> [[String: String?]] {
    var keep:Bool = false
    var ref_articles:[[String: String?]] = []
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
                    "userID":json_data["user"]["id"].string,
                    "url":json_data["url"].string
                ]
                ref_articles.append(article)
            }
            keep = true
    }
    let runloop = NSRunLoop()
    while keep && runloop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {
        //        0.1秒ごとに変数チェック
        //        response処理待ち
    }
    return ref_articles
}