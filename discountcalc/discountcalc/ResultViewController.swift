//
//  ResultViewController.swift
//  discountcalc
//
//  Created by Satoru Murakami on 2016/04/27.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var price:Int = 0
    var percent:Int = 0

    @IBOutlet weak var resultField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let percentValue = Float(percent) / 100
        let discountPrice = Float(price) * percentValue
        let offPrice = price - Int(discountPrice)
        resultField.text = "\(offPrice)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
