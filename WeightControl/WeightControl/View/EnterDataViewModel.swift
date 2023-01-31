//
//  EnterDataViewModel.swift
//  WeightControl
//
//  Created by  on 2020/2/26.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class EnterDataViewModel {
    
    var old: [Int] = []
    let male = ["男", "女"]
    var height: [Int] = []
    var weight: [Int] = []
    var old2: [Int] = UserDefaults.standard.array(forKey: "old") as? [Int] ?? []
    var male2: [String] = UserDefaults.standard.array(forKey: "male") as? [String] ?? []
    var height2: [Int] = UserDefaults.standard.array(forKey: "height") as? [Int] ?? []
    var weight2: [Int] = UserDefaults.standard.array(forKey: "weight") as? [Int] ?? []
    var times: [String] = UserDefaults.standard.array(forKey: "times") as? [String] ?? []
    var old3: Int = 51
    var male3: String = "男"
    var height3: Int = 125
    var weight3: Int = 76
    
    func addToUserDefaults() -> Float{
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: date as Date)
        old2.insert(old3, at: 0)
        male2.insert(male3, at: 0)
        height2.insert(height3, at: 0)
        weight2.insert(weight3, at: 0)
        times.insert(dateString, at: 0)
        UserDefaults.standard.set(old2, forKey: "old")
        UserDefaults.standard.set(male2, forKey: "male")
        UserDefaults.standard.set(height2, forKey: "height")
        UserDefaults.standard.set(weight2, forKey: "weight")
        UserDefaults.standard.set(times, forKey: "times")
        let high = String(format: "%.2f", Float(height3)/100)
        let num = Float(high)!
        let num2 = num * num
        let BMI: Float = Float(weight3) / num2
        let BMIString = String(format: "%.2f", BMI)
        let BMIFloat = Float(BMIString)!
        return BMIFloat
    }
    
    func setPickViewArray() {
        for o in 1...100 {
            old.append(o)
        }
        for h in 50...200 {
            height.append(h)
        }
        for w in 1...150 {
            weight.append(w)
        }
    }
}
