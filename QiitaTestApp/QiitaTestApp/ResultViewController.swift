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
    var search_articles:[[String:String?]] = []
    @IBOutlet weak var searchResultTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.view_title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
/* セルの設定 */
    
//  表示するセルの個数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.search_articles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.searchResultTable.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath)
        
        return cell
    }
    
/* おしまい */
    
}
