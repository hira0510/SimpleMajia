//
//  historyData.swift
//  GameAB2
//
//  Created by 王一平 on 2019/8/1.
//  Copyright © 2019 王一平. All rights reserved.
//

import UIKit

class HistoryData : NSObject , NSCoding{
    
    var date : String
    var answer : String
    var timer : String
    var retrytimes : String
    var times : String
    var gameresult : String
    var histroyArrayCount : [Int]
    var histroyArray : [[String]]
    
    func aa() {
        print(answer , retrytimes , timer , date , times , gameresult , histroyArrayCount)}

    init(answer : String , retrytimes : String , timer : String , date : String , times : String , gameresult : String , histroyArrayCount : [Int] , histroyArray : [[String]]) {
        self.answer = answer
        self.retrytimes = retrytimes
        self.timer = timer
        self.date = date
        self.times = times
        self.gameresult = gameresult
        self.histroyArrayCount = histroyArrayCount
        self.histroyArray = histroyArray
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(answer , forKey: "answer")
        aCoder.encode(date , forKey: "date")
        aCoder.encode(gameresult , forKey: "gameresult")
        aCoder.encode(retrytimes , forKey: "retrytimes")
        aCoder.encode(times , forKey: "times")
        aCoder.encode(timer , forKey: "timer")
        aCoder.encode(histroyArrayCount , forKey: "histroyArrayCount")
        aCoder.encode(histroyArray , forKey: "histroyArray")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.answer = aDecoder.decodeObject(forKey: "answer") as? String ?? ""
        self.date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        self.gameresult = aDecoder.decodeObject(forKey: "gameresult") as? String ?? ""
        self.timer = aDecoder.decodeObject(forKey: "timer") as? String ?? ""
        self.retrytimes = aDecoder.decodeObject(forKey: "retrytimes") as? String ?? ""
        self.times = aDecoder.decodeObject(forKey: "times") as? String ?? ""
        self.histroyArrayCount = aDecoder.decodeObject(forKey: "histroyArrayCount") as? [Int] ?? []
        self.histroyArray = aDecoder.decodeObject(forKey: "histroyArray") as? [[String]] ?? []
    }
}
