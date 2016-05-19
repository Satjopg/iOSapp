//
//  ViewController.swift
//  TrainTimeApp
//
//  Created by Satoru Murakami on 2016/05/19.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//  出発駅の入力欄
    @IBOutlet weak var startField: UITextField!
    
//  到着駅の入力欄
    @IBOutlet weak var endField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//  検索ボタンを押した時の処理
    @IBAction func searchButton(sender: AnyObject) {
        if let start = startField.text {
            print(start)
        }
        if let end = endField.text {
            print(end)
        }
    }
}

