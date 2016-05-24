//
//  ViewController.swift
//  TrainTimeApp
//
//  Created by Satoru Murakami on 2016/05/19.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//  出発駅の入力欄
    @IBOutlet weak var startField: UITextField!
    
//  到着駅の入力欄
    @IBOutlet weak var endField: UITextField!
    
//  時刻の入力欄
    @IBOutlet weak var timeField: UITextField!
    
    let myDatePicker:UIDatePicker = UIDatePicker()
    
    var toolBar:UIToolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//      時刻の入力方式を変更する
        myDatePicker.addTarget(self, action: #selector(ViewController.changedDateEvent), forControlEvents: UIControlEvents.ValueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.DateAndTime
        myDatePicker.locale = NSLocale(localeIdentifier: "ja_JP")
        myDatePicker.setDate(NSDate(), animated: true)
        timeField.inputView = myDatePicker
        
//      UIToolBarの設定
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style:.Plain, target: self, action: #selector(ViewController.tappedToolBarBtn))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style:.Plain, target: self, action: #selector(ViewController.tappedToolBarBtnToday))
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        
        timeField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//  検索ボタンを押した時の処理
    @IBAction func searchButton(sender: AnyObject) {
        if let start = startField.text {
            print(start)
        }
        if let end = endField.text {
            print(end)
        }
        
        if let time = timeField.text {
            print(time)
        }
    }
    
    internal func changedDateEvent(sender: UIDatePicker){
        
        // フォーマットを生成.
        let myDateFormatter: NSDateFormatter = NSDateFormatter()
        myDateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        myDateFormatter.timeStyle = .ShortStyle
        myDateFormatter.dateStyle = .MediumStyle
        
        // 日付をフォーマットに則って取得.
        let mySelectedDate: NSString = myDateFormatter.stringFromDate(sender.date)
        self.timeField.text = mySelectedDate as String
    }
    
    // 「完了」を押すと閉じる
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        self.timeField.resignFirstResponder()
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        myDatePicker.date = NSDate()
        changedDateEvent(myDatePicker)
    }
    
}

