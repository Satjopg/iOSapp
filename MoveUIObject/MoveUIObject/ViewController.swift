//
//  ViewController.swift
//  MoveUIObject
//
//  Created by Satoru Murakami on 2015/12/29.
//  Copyright © 2015年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redRect: UIView!
    
    
    @IBAction func right(sender: AnyObject) {
        print("rightがtapされました");
        print("移動前の座標:\(redRect.center)");
        let movepoint = CGPointMake(redRect.center.x + 10, redRect.center.y);
        redRect.center = movepoint;
        print("移動後の座標:\(redRect.center)")
    }
    
    @IBAction func left(sender: AnyObject) {
        print("leftがtapされました");
        print("移動前の座標:\(redRect.center)");
        let movepoint = CGPointMake(redRect.center.x - 10, redRect.center.y);
        redRect.center = movepoint;
        print("移動後の座標:\(redRect.center)");
    }
    
    
    @IBAction func up(sender: AnyObject) {
        print("upがtapされました");
        print("移動前の座標:\(redRect.center)");
        let movepoint = CGPointMake(redRect.center.x, redRect.center.y - 10);
        redRect.center = movepoint;
        print("移動後の座標:\(redRect.center)");
    }
    
    @IBAction func down(sender: AnyObject) {
        print("downがtapされました");
        print("移動前の座標:\(redRect.center)");
        let movepoint = CGPointMake(redRect.center.x, redRect.center.y + 10);
        redRect.center = movepoint;
        print("移動後の座標:\(redRect.center)");
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

