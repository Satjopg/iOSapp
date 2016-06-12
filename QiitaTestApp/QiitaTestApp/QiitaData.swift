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
                        "date":json_data["created_at"].string,
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

/**
 投稿数の多いタグを返す
 - return: 投稿数の多いタグ20個
 */
func getTags() -> [[String:String?]]{
//  タグ一覧を保持する
    var tags:[[String:String?]] = []
//  待機か、実行状態をコントロールする変数
    var keep:Bool = true
//  以下、タグ一覧取得
    Alamofire.request(.GET, "https://qiita.com/api/v2/tags?sort=count&per_page=20")
    .responseJSON { response in
        guard let object = response.result.value else {
            return
        }
        let json_data = JSON(object)
        json_data.forEach{ (_, json_data) in
            let count = json_data["items_count"].stringValue
            let tag: [String:String?] = [
                "tag":json_data["id"].string,
                "count":count
            ]
            tags.append(tag)
        }
        keep = false
    }
    
    let runloop = NSRunLoop.currentRunLoop()
//  処理待ち
    while keep && runloop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {}
    return tags
}

func refresh_articles() -> [[String: String?]] {
    var keep:Bool = true
    var ref_articles:[[String: String?]] = []
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
            keep = false
    }
    let runloop = NSRunLoop()
    while keep && runloop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {}
    return ref_articles
}

/**
 指定したタグに関する記事を取得して返す
 - parameter tag: タグの名前
 - return: 指定したタグの記事（最新記事40個)
 */
func search_Articles(tag:String) -> [[String: String?]] {
    var keep:Bool = true
    var tag_articles: [[String: String?]] = []
    Alamofire.request(.GET, "https://qiita.com/api/v2/tags/"+tag+"/items?per_page=40")
        .responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            let json_data = JSON(object)
            json_data.forEach{ (_, json_data) in
                let article: [String:String?] = [
                    "title":json_data["title"].string,
                    "userID":json_data["user"]["id"].string,
                    "url":json_data["url"].string,
                    "date":json_data["created_at"].string
                ]
                tag_articles.append(article)
            }
            keep = false
    }
    //  処理待ち
    let runloop = NSRunLoop.currentRunLoop()
    while keep && runloop.runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 0.1)) {}
    return tag_articles
}