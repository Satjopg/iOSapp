//
//  ViewController.swift
//  testTransitionApp
//
//  Created by Satoru Murakami on 2016/03/09.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

// UIGestureRecognizer:画面がタップされたのを認識するクラス
// Delegate:プロトコル。今回を例に説明すると〇〇Delegateというのは〇〇のプロトコルになる。
// 何をしているのかというと、〇〇というクラスの処理をUIViewControllerのインスタンスに任せている。
// 今回は、画面がタップされた時の処理を画面全体のクラスで処理を行うようにしている。
class ViewController: UIViewController ,UIGestureRecognizerDelegate {
    // ViewController2に渡すメッセージ
    let toVC2Text = "from VC1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // シングルタップを変数として可視化:target(タップされたかを認識する場所):
        // self(画面全体), action(タップイベント名。最後に：をつける。)
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        
        // delegateの先（依頼先）をself(UIViewController)にすることを宣言
        tapGesture.delegate = self;
        
        //　可視化(画面に反映)する
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // タップイベント.
    func tapped(sender: UITapGestureRecognizer){
        print("タップ")
        
        // ViewController2 へ遷移するために Segue を呼び出す
        performSegueWithIdentifier("toViewController2",sender: nil)
        
}

    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toViewController2") {
            let vc2: ViewController2 = (segue.destinationViewController as? ViewController2)!
            // ViewControllerのvc2Textにメッセージを設定
            vc2.vc2Text = toVC2Text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

