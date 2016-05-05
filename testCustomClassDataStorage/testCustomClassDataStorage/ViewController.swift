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
        
        // シリアライズ処理
        let archiveData = NSKeyedArchiver.archivedDataWithRootObject(data)
        // シリアライズしたデータをNSUserDefaultsに保存
        userdefaults.setObject(archiveData, forKey: "data")
        // 同期
        userdefaults.synchronize()
        
        // デシリアライズ処理
        // シリアライズしたデータを取得
        if let storedData = userdefaults.objectForKey("data") as? NSData{
               // デシリアライズする
            if let unarchiveData = NSKeyedUnarchiver.unarchiveObjectWithData(storedData) as? MyData{
                if let value = unarchiveData.value {
                    print("デシリアライズデータ" + value)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

