//
//  ViewController2.swift
//  testTransitionApp
//
//  Created by Satoru Murakami on 2016/03/09.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var label:UILabel!
    
    var vc2Text:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if vc2Text != nil {
            // ViewControllerからのメッセージを表示する
            label.text = vc2Text
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}