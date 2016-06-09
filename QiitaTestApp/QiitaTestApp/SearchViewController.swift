//
//  SearchViewController.swift
//  QiitaTestApp
//
//  Created by Satoru Murakami on 2016/06/09.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
//  取得したタグを保持する（並び順は投稿数が多い順）
    var tags: [[String:String?]] = []
//  サーチバーのモデル
    var searchBar:UISearchBar!
//  取得したタグを表示するテーブル
    @IBOutlet weak var tagTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagTableView.delegate = self
        tagTableView.dataSource = self
        setupSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
/* 以下、検索窓関連 */
    
//  検索窓の作成
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "タグを入力してください"
        searchBar.showsCancelButton = true
        searchBar.keyboardType = UIKeyboardType.Default
        searchBar.showsSearchResultsButton = false
        searchBar.autocapitalizationType = UITextAutocapitalizationType.None
        self.navigationItem.titleView = searchBar
        self.navigationItem.titleView?.frame = searchBar.frame
    }
    
//  Cancelボタンをおした時の挙動
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
//  検索ボタン（キーボードに出る）をおした時の挙動
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        performSegueWithIdentifier("searchResultSegue", sender: self.searchBar)
    }
    
/* おしまい */

/* テーブルに表示するセルの設定 */
    
//  セルの個数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
//  セルに表示するもの
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tagTableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath)
        let tag = tags[indexPath.row]
        cell.textLabel?.text = tag["tag"]!
        cell.detailTextLabel?.text = tag["count"]!! + "件の投稿"
        return cell
    }
    
/* おしまい */
    
//  画面遷移時の動作
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextView = segue.destinationViewController as! ResultViewController
        if self.searchBar.text != "" {
            nextView.view_title = self.searchBar.text!
        }
    }
    
}
