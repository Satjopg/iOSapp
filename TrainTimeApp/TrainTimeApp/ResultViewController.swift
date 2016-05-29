//
//  ResultViewController.swift
//  TrainTimeApp
//
//  Created by Satoru Murakami on 2016/05/26.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var start:String = ""
    var end:String = ""
    var train_code:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(start)
        print(end)
        print(train_code)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
