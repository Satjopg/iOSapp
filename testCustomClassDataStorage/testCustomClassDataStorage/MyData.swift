//
//  MyData.swift
//  testCustomClassDataStorage
//
//  Created by Satoru Murakami on 2016/05/02.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

/*
    簡単なオリジナルクラスの定義
    
    永続的にこのクラスのデータを扱いたい場合はシリアライズする必要がある
    ＊シリアライズ
    オブジェクトの内容をバイナリに変換すること
    （その逆のことをデシリアライズという）

    今回はオリジナルクラス（MyData）のデータをNSData型に変換する処理にあたる。
    
    シリアライズ用のクラス
    NSKeyedArchiver
    デシリアライズ用のクラス
    NSKeyedUnarchiver
    
    利用するために、NSCodingプロトコルを使用する。
    →実装しなければならないメソッドを調べて、自分のクラスに実装する。
    →NSCoderクラスが利用されているので、親クラスのNSObjectを継承する。

*/

import Foundation

class MyData:NSObject, NSCoding {
    var value : String?
    
    override init() {
        
    }
    func encodeWithCoder(aCoder: NSCoder){
            aCoder.encodeObject(value, forKey: "value")
    }
    required init?(coder aDecoder: NSCoder){
        value = aDecoder.decodeObjectForKey("value") as? String
    }
}