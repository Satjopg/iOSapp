//
//  SearchViewController.swift
//  QiitaTestApp
//
//  Created by Satoru Murakami on 2016/06/09.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//  取得したタグを保持する（並び順は投稿数が多い順）
    var tags: [[String:String?]] = []
//  取得したタグを表示するテーブル
    @IBOutlet weak var tagTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagTableView.delegate = self
        tagTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tagTableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath)
        let tag = tags[indexPath.row]
        cell.textLabel?.text = tag["tag"]!
        cell.detailTextLabel?.text = tag["count"]!! + "件の投稿"
        return cell
    }
}
