//
//  ViewController.swift
//  MyToDoList
//
//  Created by Satoru Murakami on 2016/05/06.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

/*
    永続的なデータの扱いの練習としてtodoリストアプリの作成を行う
    このクラスの役割は
    ・テーブルが操作された時のアクション
    ・テーブルの表示に利用するデータ管理
    である。
    これはそれぞれdelegateとdatasourceで定義されているので
    これを継承して、このクラスで処理をすることを明示する。
*/

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    // Tableviewのインスタンス
    @IBOutlet weak var tableview: UITableView!
    // todolistのデータを保持する配列
    var todoList = [String]()
    
    // +ボタンをおした時の処理
    @IBAction func barButton(sender: UIBarButtonItem) {
        
        // アラートダイアログ生成
        let alertController = UIAlertController(
        title: "TODO追加",
        message: "TODOを入力してください",
        preferredStyle: UIAlertControllerStyle.Alert)
        
        // テキストエリア追加
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        // OKボタンの生成
        let okaction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
            { (action:UIAlertAction) -> Void in
            // ボタンが押された時の処理
            // テーブルビューの先頭にセルを加える
            
            // 初期値nilなのでアンラップ処理
            if let textfield = alertController.textFields?.first {
                // 先頭に追加する - 配列のメソッドinsertの利用
                self.todoList.insert(textfield.text!, atIndex: 0)
                
                // テーブルに行（セル）が追加されたことを通知
                // 通知を行うことで再描画されて実際に見える形で追加される
                self.tableview.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Right)
            }
        }
        //　アラートダイアログにボタンを生成
        alertController.addAction(okaction)
        
        // cancelボタンの生成
        // 押された時の挙動→ボタンの追加という流れ
        let cancelaction = UIAlertAction(
            title: "CANCEL",
            style: UIAlertActionStyle.Cancel,
            handler:nil)
        // ボタンの追加
        alertController.addAction(cancelaction)
        // ダイアログの可視化
        presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // テーブルの行数（セルの数）を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // データの数だけセルはあるのでそれを返す
        return self.todoList.count
    }
    // 表示するセルを返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // storyboardで指定したtodoCellを利用して再利用可能なセルを取得する
        let cell = tableview.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath)
        // 行番号にあったものを取得
        let todoTitle = todoList[indexPath.row]
        // cellのラベルに追加した内容を描画
        cell.textLabel!.text = todoTitle
        return cell
    }
}

