//
//  ViewController.swift
//  freeFall
//
//  Created by Satoru Murakami on 2016/02/02.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    // 動く物体の宣言
    @IBOutlet var balls: [UIView]!
    // 壁の宣言
    @IBOutlet var walls: [UIView]!
    // 障害物の宣言
    @IBOutlet var obstacles: [UIView]!
    // 落とし穴の追加
    @IBOutlet var falls: [UIView]!
    // ゴールの宣言
    @IBOutlet weak var goal: UILabel!
    // 現在の時間
    @IBOutlet weak var currentTime: UILabel!
    // レコードタイム
    @IBOutlet weak var courceRecord: UILabel!
    // 物体の動きを計算してくれるクラスのインスタンス
    var dynamicAnimator:UIDynamicAnimator!
    // 本体の動きを検知するクラスのインスタンス
    let motionManager = CMMotionManager()
    // タイマークラスのインスタンス
    var timer: NSTimer!
    var time = 0.0
    // 初期の物体の表示位置を記憶するための配列
    var ballsInfo:[(center:CGPoint, transform:CGAffineTransform)] = []
    var obstaclesInfo:[(center:CGPoint, transform:CGAffineTransform)] = []
    
    // アプリが起動した時に行う動作
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.saveInitialPoint()
        self.startgame()
    }
    
    // ゲームの動作を表す
    func startgame() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let courceRecordTime = userDefaults.doubleForKey("courceRecordTime")
        if courceRecordTime == 0 {
            userDefaults.setDouble(10.0, forKey: "courceRecordTime")
        } else {
            print("コースレコードは\(courceRecordTime)です")
        }
        self.courceRecord.text = String(format: "%.1f", userDefaults.doubleForKey("courceRecordTime"))
        
        self.time = 0.0
        // 重力が働く物体（ボール）
        let gravityBehavior = UIGravityBehavior(items: self.balls)
        
        // 衝突の宣言
        let collisionBehavior = UICollisionBehavior(items: self.balls)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self

        
        // 移動しない壁の追加
        for boundaries in [walls, falls]{
            for boundary in boundaries{
                
            // 力がかかっても移動しないものを宣言（衝突は検知される）
            collisionBehavior.addBoundaryWithIdentifier(
                boundary.description,
                forPath: UIBezierPath(rect: boundary.frame)
            )
            }
        }
        
        // ゴールの追加（固定なので壁と同じ）
        collisionBehavior.addBoundaryWithIdentifier(
            self.goal.description,
            forPath: UIBezierPath(rect: self.goal.frame)
        )
        
        // 障害物の追加（力がかからない）
        // 無重力状態の物体ができる
        for obstacle in obstacles{
            collisionBehavior.addItem(obstacle)
        }
        
        // 表示するものを宣言
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        // 実際に動かしたいものを宣言
        dynamicAnimator.addBehavior(gravityBehavior)
        // 実際に衝突が行われることを宣言
        dynamicAnimator.addBehavior(collisionBehavior)
        
        // 通知間隔：10Hz
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 10.0
        
        // 本体を傾けることで画面の物体を動くように設定する
        // ジャイロスコープと加速度スコープの利用
        self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(),
            withHandler:
            {
            (deviceMotion:CMDeviceMotion?, error:NSError?) in
                // X軸に傾けた角度（単位：ラジアン）
                let x = CGFloat((deviceMotion?.attitude.roll)!)
                // Y軸に傾けた角度（単位：ラジアン）
                let y = CGFloat((deviceMotion?.attitude.pitch)!)
                // 傾けた方向に力がかかるように設定
                gravityBehavior.gravityDirection = CGVectorMake(x, y)
                // 物体の速度（物体にかかる力の大きさ）を設定
                gravityBehavior.magnitude = 0.5
            }
        )
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            1.0/10.0,
            target: self,
            selector: "timerFnc",
            userInfo: nil,
            repeats: true)
    }
    
    // ボールが画面上の物体と衝突が起きた時の処理
    func collisionBehavior(behavior: UICollisionBehavior!,
        beganContactForItem item: UIDynamicItem!,
        withBoundaryIdentifier identifier: NSCopying!,
        atPoint p: CGPoint)
    {
        // UIViewとLabelの差を利用してゴールの判断を行う
        
        // 壁の時は処理を終了
        // 壁（画面の端）の時はnilとなる
        if identifier == nil {
            return
        }
        // 他の物でも処理を終了
        // UIViewへの衝突なら終了
        var ck = true
        for ball in balls {
            if item as? UIView == ball {
                ck = false
                break
            }
        }
        if ck {
            return
        }
        // ゴールに衝突したらすべての動きを止めてユーザーに報告
        // つまりLabelに衝突したら
        if identifier as? String == goal.description {
            print("ゴール！")
            
            var message = ""
            if courceRecordUpdate(self.time) {
                message = "ベストレコード更新！！"
            }
            
            // 画面を止める
            stopGame()
            // ユーザーに報告する
            let alert = UIAlertController(
                title: "Goal",
                message: message,
                preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alert,
                animated: true,
                completion: nil)
            alert.addAction(UIAlertAction(
                title: "one more game!",
                style: UIAlertActionStyle.Default)
                {action in self.reStartGame()})
        }
        
        // 落とし穴に落ちた時の処理
        for fall in self.falls {
            // 落とし穴とボールが衝突したかの判定
            if identifier as? String == String(fall.description) {
                // 画面停止
                stopGame()
                // ユーザーに表示する
                let alert = UIAlertController(
                title: "fall in hool",
                message: nil,
                preferredStyle: UIAlertControllerStyle.Alert)
                // 選択肢の追加
                alert.addAction(UIAlertAction(
                    title: "one more game",
                    style: UIAlertActionStyle.Default)
                    {action in self.reStartGame()})
                // 可視化
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    // 初期の配置を記憶する
    func saveInitialPoint() {
        
        self.ballsInfo = []
        self.obstaclesInfo = []
        
        for obs in self.balls {
            self.ballsInfo.append(center: CGPoint(x:obs.center.x,y:obs.center.y), transform: obs.transform as CGAffineTransform)
        }
        
        for obs in self.obstacles {
            self.obstaclesInfo.append(center: CGPoint(x:obs.center.x,y:obs.center.y), transform: obs.transform as CGAffineTransform)
        }
    }
    
    // 初期の配置を保持していた配列から読み取り
    // 移動していたものを元に戻す
    func loadInitialPoint() {
        for var i = 0; i < self.ballsInfo.count; i++ {
            self.balls[i].transform = self.ballsInfo[i].transform
            self.balls[i].center = self.ballsInfo[i].center
        }
        for var i = 0; i < self.obstaclesInfo.count;i++ {
            self.obstacles[i].transform = self.obstaclesInfo[i].transform
            self.obstacles[i].center = self.obstaclesInfo[i].center
        }
    }
    
    // 再びゲームを始める
    func reStartGame() {
        self.loadInitialPoint()
        self.startgame()
    }
    
    // 画面の動きを止める
    func stopGame() {
        self.dynamicAnimator.removeAllBehaviors()
        self.motionManager.stopDeviceMotionUpdates()
        self.timer.invalidate()
    }
    
    // 時間を測定し、画面に表示する
    func timerFnc() {
        self.time += 0.1
        dispatch_async(dispatch_get_main_queue(), {() in
            self.currentTime.text = String(format: "%.2f", self.time)
        }
        )
    }
    
    // レコードタイムを更新する
    func courceRecordUpdate(refTime: Double) -> Bool{
        var boolreturn = false
        if refTime < NSUserDefaults.standardUserDefaults().doubleForKey("courceRecordTime") {
            NSUserDefaults.standardUserDefaults().setDouble(refTime, forKey: "courceRecordTime")
            boolreturn = NSUserDefaults.standardUserDefaults().synchronize()
        }
        return boolreturn
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

