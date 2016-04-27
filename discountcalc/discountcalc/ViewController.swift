//
//  ViewController.swift
//  discountcalc
//
//  Created by Satoru Murakami on 2016/04/27.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /** 
     storyboardのテキストフィールドの定義
     定義自体はstoryboard上で行われているが
     追加で処理をするときはstoryboardとconnectしたうえで
     記述を行っていく。
    */
    @IBOutlet weak var priceField: UITextField!
    
    /**
     storyboard等で定義されたビューに追加処理等を書く
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    /**
     iOS本体のメモリ容量が圧迫された時に呼び出されるメソッド
     アプリ内で利用しない情報を破棄する処理を書く必要がある
     （記述しなくても動く→今回は記述しない）
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     以下、数字のボタンをおした時の処理
     実際の処理はtapnumにまかせている
    */
    @IBAction func tap1Button(sender: AnyObject) {
        tapnum("1")
    }
    
    @IBAction func tap2Button(sender: AnyObject) {
        tapnum("2")
    }
    
    @IBAction func tap3Button(sender: AnyObject) {
        tapnum("3")
    }
    
    @IBAction func tap4Button(sender: AnyObject) {
        tapnum("4")
    }
    
    @IBAction func tap5Button(sender: AnyObject) {
        tapnum("5")
    }
    
    @IBAction func tap6Button(sender: AnyObject) {
        tapnum("6")
    }

    @IBAction func tap7Button(sender: AnyObject) {
        tapnum("7")
    }
    
    @IBAction func tap8Button(sender: AnyObject) {
        tapnum("8")
    }
    
    @IBAction func tap9Button(sender: AnyObject) {
        tapnum("9")
    }
    
    @IBAction func tap0Button(sender: AnyObject) {
        tapnum("0")
    }
    
    @IBAction func tap00Button(sender: AnyObject) {
        tapnum("00")
    }
    
    // Clearボタンは値を０にする
    @IBAction func tapclearButton(sender: AnyObject) {
        priceField.text = "0"
    }
    
    
    /**
     数字のボタンが押された時に、テキストフィールドに反映する処理
     - parameter number:末尾に追加する数字(String)
    */
    func tapnum(number: String) {
        let value = priceField.text! + number
        if let price = Int(value) {
            priceField.text = "\(price)"
        }
    }
    
    /**
     最後の画面から戻ってきた時の処理
     
     （restartというsegueが起こった時に起こるイベント）
     - parameter segue:遷移
    */
    @IBAction func restart(segue: UIStoryboardSegue){
        priceField.text = "0"
    }

}

