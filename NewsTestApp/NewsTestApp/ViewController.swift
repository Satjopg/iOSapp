//
//  ViewController.swift
//  NewsTestApp
//
//  Created by Satoru Murakami on 2016/05/10.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate {
    // RSSのURL
    let getURL:NSURL? = NSURL(string: "http://rss.dailynews.yahoo.co.jp/fc/rss.xml")
    
    @IBOutlet weak var tableView: UITableView!
    
    // デシリアライズ処理（デコード）が必要なときは呼ばれる
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let newsURL = getURL {
            let parser:NSXMLParser! = NSXMLParser(contentsOfURL: newsURL)
            parser!.delegate = self;
            parser!.parse()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // データを保持する
    var items:[Item] = [Item]()
    
    // 表示するセルの数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    // セルをタップした時の処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // タップしたセルの情報を取得
        let item = items[indexPath.row]
        // 取得先のURLからそこに飛ぶように設定
        UIApplication.sharedApplication().openURL(NSURL(string:item.url)!)
    }
    
    var currentElementName : String!
    
    let itemElementName = "item"
    let titleElementName = "title"
    let linkElementName   = "link"
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        self.currentElementName = nil
        if elementName == itemElementName {
            items.append(Item())
        } else {
            currentElementName = elementName
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElementName = nil
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if items.count > 0 {
            let lastItem = items[items.count-1]
            if let currentElementName = currentElementName {
                if currentElementName == titleElementName {
                    let tmpString : String? = lastItem.title
                    lastItem.title = (tmpString != nil) ? tmpString! + string : string
                } else if currentElementName == linkElementName {
                    lastItem.url = string
                }
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        self.tableView.reloadData()
    }
    
    class Item {
        var title : String!
        var url : String!
    }
}

