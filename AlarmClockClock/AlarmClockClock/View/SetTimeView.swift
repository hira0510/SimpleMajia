//
//  SetTimeView.swift
//  AlarmClockClock
//
//  Created by Hira on 2020/2/12.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class SetTimeView: NSObject {
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var setDataPicker: UIDatePicker!
    @IBOutlet weak var switchOpen: UISwitch!
    @IBOutlet weak var suggestTitle: UILabel!
    @IBOutlet weak var animeImg: UIImageView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    func setViewController(which: Int, open: Bool) {
        switch which {
        case 0:
            mainTitle.text = "設置喝水間隔時間"
            mainTitle.textColor = UIColor.white
            animeImg.image = UIImage(named: "mylove2")
            bgImg.image = UIImage(named: "water")
            bgView.backgroundColor = UIColor.black
            completeBtn.setTitleColor(UIColor.white, for: .normal)
            completeBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.33)
            switchOpen.isOn = open
            suggestTitle.textColor = UIColor.white
            suggestTitle.text =  "喝水時只要花點小功夫，\n可以讓健康效果加倍唷！\n聽說喝水的要領就是\n一次喝150~250ml，\n一天喝6~8次，\n還有睡覺前後一定要喝水！\n 快點來定時喝水吧！"
            setDataPicker.datePickerMode = .countDownTimer
            setDataPicker.tintColor = UIColor.white
            setDataPicker.setValue(UIColor.white, forKeyPath: "textColor")
            setDataPicker.setValue(false, forKey: "highlightsToday")
        case 1:
            mainTitle.text = "設置吃飯間隔時間"
            mainTitle.textColor = UIColor.white
            animeImg.image = UIImage(named: "mylove3")
            bgImg.image = UIImage(named: "Fire02")
            bgView.backgroundColor = UIColor.black
            completeBtn.setTitleColor(UIColor.white, for: .normal)
            completeBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.33)
            switchOpen.isOn = open
            suggestTitle.textColor = UIColor.white
            suggestTitle.text = "聽說早餐為全天30%的能量和營養，所以起早一點吃頓健康的早餐是最划算的。吃飯要慢慢吃才有利於人體對食物的消化以及吸收。晚餐則不能太晚吃喔，會不易消化形成肥胖！"
            setDataPicker.datePickerMode = .countDownTimer
            setDataPicker.tintColor = UIColor.white
            setDataPicker.setValue(UIColor.white, forKeyPath: "textColor")
            setDataPicker.setValue(false, forKey: "highlightsToday")
        case 2:
            mainTitle.text = "設置起床時間"
            mainTitle.textColor = UIColor.black
            animeImg.image = UIImage(named: "mylove1")
            bgImg.image = UIImage(named: "morning")
            bgView.backgroundColor = UIColor.white
            completeBtn.setTitleColor(UIColor.black, for: .normal)
            completeBtn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.57)
            switchOpen.isOn = open
            suggestTitle.textColor = UIColor.black
            suggestTitle.text = "聽說7點21分後起床最好。\n早起的好處就是\n精神狀態會更好、\n不容易長胖，身材好、\n不易生病，提升免疫力、\n注意力集中！"
            setDataPicker.datePickerMode = .time
            setDataPicker.tintColor = UIColor.black
            setDataPicker.setValue(UIColor.black, forKeyPath: "textColor")
            setDataPicker.setValue(false, forKey: "highlightsToday")
        default:
            mainTitle.text = "設置睡覺時間"
            mainTitle.textColor = UIColor.black
            animeImg.image = UIImage(named: "mylove0")
            bgImg.image = UIImage(named: "night")
            bgView.backgroundColor = UIColor.white
            completeBtn.setTitleColor(UIColor.black, for: .normal)
            completeBtn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.57)
            switchOpen.isOn = open
            suggestTitle.textColor = UIColor.black
            suggestTitle.text = "聽說大概花一至二個星期的充足睡眠可以補回幾天前所流失的睡眠時間。如果補回睡眠時間後還是每天覺得累，愛睏需要睡超過 9 小時以上才夠時，就有可能是過勞或潛藏某些疾病的風險，最好去醫院檢查一下身體狀況。"
            setDataPicker.datePickerMode = .time
            setDataPicker.setValue(UIColor.black, forKeyPath: "textColor")
            setDataPicker.setValue(false, forKey: "highlightsToday")
        }
    }
}
