//
//  ViewController.swift
//  moveUIViewFromAccelerometerGyro
//
//  Created by Satoru Murakami on 2016/01/08.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var redRect: UIView!
    
    let motionManager = CMMotionManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("移動前の座標:\(redRect.center)");
        
        //1.0/60.0=60hz
        motionManager.accelerometerUpdateInterval = 1.0/60.0;
        
        //監視を開始する
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
            {
                (accelerometerData:CMAccelerometerData?, error:NSError?) in
                print("加速度センサが監視されています")
                print(accelerometerData?.description);
                
                let lenX = CGFloat(accelerometerData!.acceleration.x) * 10;
                let lenY = CGFloat(accelerometerData!.acceleration.y * -1) * 10;
                
                self.redRect.center = CGPointMake(self.redRect.center.x + lenX, self.redRect.center.y + lenY);
                
            }
        )
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

