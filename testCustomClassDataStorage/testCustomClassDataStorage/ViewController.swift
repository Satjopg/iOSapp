//
//  ViewController.swift
//  testCustomClassDataStorage
//
//  Created by Satoru Murakami on 2016/05/02.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

/*
    自分で作ったクラスのデータの永続保持の練習を行う
    保持の仕方はNSUserDefaultsを利用する
    NSUserDefaultsに関しては”testDataStorage”に説明を載せている
*/

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userdefaults = NSUserDefaults.standardUserDefaults()
        let data =  MyData()
        data.value = "test"
        userdefaults.setObject(data, forKey: "data")
        userdefaults.synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

