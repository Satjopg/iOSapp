//
//  ViewController.swift
//  TrainTimeApp
//
//  Created by Satoru Murakami on 2016/05/19.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//  出発駅の入力欄
    @IBOutlet weak var startField: UITextField!
//  到着駅の入力欄
    @IBOutlet weak var endField: UITextField!
    
//  時刻の入力欄
    @IBOutlet weak var timeField: UITextField!
    
//  使用電車の入力欄
    @IBOutlet weak var trainField: UITextField!
    
//  検索ボタン
    @IBOutlet weak var myButton: UIButton!
    
//  日付と時刻を入力するためのUIDatePicker
    let myDatePicker:UIDatePicker = UIDatePicker()
    
//  DatePickerの動作を補助するためのツールバー
    var toolBar:UIToolbar = UIToolbar()
    
//  路線を入力するためのUIPickerView
    var trainPicker:UIPickerView = UIPickerView()
    
//  trainPickerのツールバー
    var trainToolbar:UIToolbar = UIToolbar()
    
//  路線名
    let trainArr:NSArray = ["","小田急線", "山手線"]
    
    
//  画面表示時の動作
    override func viewDidLoad() {
        super.viewDidLoad()
    
//      時刻の入力方式を変更する
        myDatePicker.addTarget(self, action: #selector(ViewController.changedDateEvent), forControlEvents: UIControlEvents.ValueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.DateAndTime
        myDatePicker.locale = NSLocale(localeIdentifier: "ja_JP")
        myDatePicker.setDate(NSDate(), animated: true)
        timeField.inputView = myDatePicker
        
//      UIToolBarの設定(UIDatePickerのツールバーの設定)
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.clearColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style:.Plain, target: self, action: #selector(ViewController.tappedToolBarBtn))
        let toolBarBtnToday = UIBarButtonItem(title: "現在時刻", style:.Plain, target: self, action: #selector(ViewController.tappedToolBarBtnToday))
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        
        timeField.inputAccessoryView = toolBar
        
//      UIPickerviewの設定(使用列車の入力方式)
        trainPicker.frame = CGRectMake(0,0,self.view.bounds.width, 250.0)
        trainPicker.delegate = self
        trainPicker.dataSource = self
        trainField.inputView = trainPicker
        
//      UIToolBarの設定（UIPickerViewのツールバー）
        trainToolbar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        trainToolbar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        trainToolbar.barStyle = .BlackTranslucent
        trainToolbar.tintColor = UIColor.whiteColor()
        trainToolbar.backgroundColor = UIColor.clearColor()
        
//      trainToolbarのボタンの設定,可視化
        let trainbtn = UIBarButtonItem(title: "完了", style:.Plain, target:self, action:#selector(ViewController.completeView))
        trainToolbar.items = [trainbtn]
        trainField.inputAccessoryView = trainToolbar
        
//      戻るボタンの設定（遷移先に表示される）
        let backbut = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backbut
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//  検索ボタンの動作を表す関数
//  動作自体は画面遷移なので中身のコードは不要
    @IBAction func searchButton(sender: AnyObject) {
    }
    
//  DatePickerで値を動かした時に起こる動作
    internal func changedDateEvent(sender: UIDatePicker){
        let calender:NSCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let compornents:NSDateComponents = calender.components([.Year, .Month, .Day, .Weekday, .Hour, .Minute], fromDate: sender.date)
        
        let weekday:Int = compornents.weekday
        
        let myDateFormatter:NSDateFormatter = NSDateFormatter()
        myDateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        myDateFormatter.dateFormat = "MM月dd日(\(myDateFormatter.shortWeekdaySymbols[weekday-1])) HH時mm分"
        
        let mySelectedDate:NSString = myDateFormatter.stringFromDate(sender.date)
        self.timeField.text = mySelectedDate as String
    }

// 「完了」を押すと閉じる(DatePickerのツールバー)
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        self.timeField.resignFirstResponder()
    }
    
// 「現在時刻」を押すと現在時刻をセットする(DatePickerのツールバー)
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        myDatePicker.date = NSDate()
        changedDateEvent(myDatePicker)
    }
    
//  「完了」を押すと閉じる（UIPickerView）
    func completeView(sender:UIBarButtonItem) {
        self.trainField.resignFirstResponder()
    }
    
    
///     以下UIPickerViewの設定
    
    //表示列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //表示個数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return trainArr.count
    }
    
    //表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return trainArr[row] as! String
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.trainField.text = trainArr[row] as! String
    }
    
///     おしまい
    
    
//  検索ボタンをおした時の処理
//  次の画面に入力した文字列を受渡している
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//      遷移先の情報を取得
        let viewController = segue.destinationViewController as! ResultViewController
//      以下項目欄が空ならエラーメッセージを表示する
//      そうでなければ、値を受け渡す
        if self.startField.text != "" {
            viewController.start = self.startField.text!
        } else {
            self.alertevent("出発駅の記入")
        }
        if self.endField.text != "" {
            viewController.end = self.endField.text!
        } else {
            self.alertevent("到着駅の記入")
        }
        if self.trainField.text != "" {
            switch trainField.text! {
            case "小田急線":
                viewController.train_code = "25001"
            case "山手線":
                viewController.train_code = "11302"
            default:
                self.alertevent("路線の選択")
            }
        } else {
            self.alertevent("路線の選択")
        }
    }
    
//  画面遷移時に入力項目が足りなかった時に表示する
    func alertevent(sender:String){
        
        let am:String = sender + "が足りません"
        
        let alert:UIAlertController = UIAlertController(title: "Error!!", message: am, preferredStyle: .Alert)
        let defaultaction = UIAlertAction(title: "OK", style: .Default){ (action) in
            if let navCon = self.navigationController {
                navCon.popViewControllerAnimated(true)
            }
        }
        alert.addAction(defaultaction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}