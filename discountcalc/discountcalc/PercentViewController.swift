//
//  PercentViewController.swift
//  discountcalc
//
//  Created by Satoru Murakami on 2016/04/27.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class PercentViewController: UIViewController {
    var price:Int = 0

    @IBOutlet weak var percentField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     基本的に前の画面と同じ処理なので説明略
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
    
    @IBAction func tapclearButton(sender: AnyObject) {
        percentField.text = "0"
    }

    
    /**
     数字のボタンが押された時に、テキストフィールドに反映する処理
     - parameter number:末尾に追加する数字(String)
     */
    func tapnum(number: String) {
        let value = percentField.text! + number
        if let price = Int(value) {
            percentField.text = "\(price)"
        }
    }
}
