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
        //print("移動前の座標:\(redRect.center)");
        
        //1.0/60.0=60hz
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
        
        //監視を開始する
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
            {
                (deviceMotion:CMDeviceMotion?, error:NSError?) in
                print("加速度センサが監視されています")
                print(deviceMotion?.description);
                
                let width = self.view.frame.size.width
                let height = self.view.frame.size.height
                
                print("幅：\(width)")
                print("高さ：\(height)")
                
                let fromX = self.redRect.center.x
                let fromY = self.redRect.center.y
                
                let xAngle = 180 * (deviceMotion?.attitude.roll)! / M_PI * 0.5
                let yAngle = 180 * (deviceMotion?.attitude.pitch)! / M_PI * 0.5
                
                //print("X軸角度：\(xAngle)")
                //print("Y軸角度：\(yAngle)")
                
                let lenX = CGFloat(xAngle)
                let lenY = CGFloat(yAngle)
                
                var toX = fromX + lenX
                var toY = fromY + lenY
                
                let ajustX = self.redRect.frame.width*0.5
                let ajustY = self.redRect.frame.width*0.5
                
                if toX < ajustX {
                    toX = ajustX
                } else if toX > width - ajustX {
                    toX = width - ajustX
                }
                
                if toY < ajustY {
                    toY = ajustY
                } else if toY > height - ajustY {
                    toY = height - ajustY
                }
                
                self.redRect.center = CGPointMake(toX, toY)
            }
        )
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

