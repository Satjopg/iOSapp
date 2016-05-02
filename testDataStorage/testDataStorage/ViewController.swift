//
//  ViewController.swift
//  testDataStorage
//
//  Created by Satoru Murakami on 2016/05/02.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

/*
    永続的データの扱いの練習
    本アプリの挙動は
    １．テキストフィールドに文字を入力
    ２．ボタンを押して文字を保存
    ３．次回起動時にその文字をテキストフィールドに表示
    となる。
    今回は保存の仕組みとしては一番簡単なNSUserDefaltsを利用する

    ＊NSUserDefaults
    永続的にデータを保存するための仕組みの１つ（最も単純）。
    保存方式としてはkey=valueである。
    詳細な仕組みは、アプリからメモリに書き込んだデータをplist形式のファイルに同期するというものである。
    少量のデータかつ機密性の低いものに関して適していると言える。

    ＊＊備忘録ゆえコメント量が多いのはあしからず。
*/
import UIKit

class ViewController: UIViewController {
    // テキストフィールドの宣言
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        // 画面表示処理実行
        super.viewDidLoad()
        
        // NSUserDefaultsのインスタンスの生成
        let userdata = NSUserDefaults.standardUserDefaults()
        
        // keyに対応した値を取り出すと同時に、
        // 取り出した値が存在するか（nilじゃないか）確認 if let文
        if let value = userdata.stringForKey("text"){
            // nilでなければテキストフィールドにその値を表示
            textField.text = value
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // ボタンをおした時の挙動
    @IBAction func savedataButton(sender: AnyObject) {
        // NSUserDefaultsのインスタンスを生成
        let userDefaluts = NSUserDefaults.standardUserDefaults()
        
        // NSUserDefaultsに値を保存する
        // keyは"text"とする
        userDefaluts.setObject(textField.text, forKey: "text")
        
        // アプリがクラッシュする可能性もあるのでキャッシュメモリとplistとの
        // 同期処理を明示的に記述をする(同期はプログラムが自動的にしてくれる)
        userDefaluts.synchronize()
    }

}

