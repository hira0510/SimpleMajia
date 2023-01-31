//
//  MenuViews.swift
//  AlarmClockClock
//
//  Created by Hira on 2020/2/13.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class MenuViews: NSObject {
    @IBOutlet weak var view1: MenuView!
    @IBOutlet weak var view2: MenuView!
    @IBOutlet weak var view3: MenuView!
    @IBOutlet weak var view4: MenuView!
    @IBOutlet weak var bgView: UIView!
    
    var open: [Bool] = UserDefaults.standard.array(forKey: "open") as? [Bool] ?? [false, false, false, false]
    var time: [String] = UserDefaults.standard.array(forKey: "time") as? [String] ?? ["", "", "", ""]
    var timer: Timer?
    var timing: [Int] = [0, 0]

    let songNum = ["drink", "eat", "getUp", "sleep"]

    func setViews() {
        let viewArray = [view1, view2, view3, view4]
        for i in 0...viewArray.count - 1 {
            if time[i] != "" {
                viewArray[i]?.timeLable.text = time[i]
            } else {
                viewArray[i]?.timeLable.text = "00:00"
            }
            viewArray[i]?.simpleSwitch.isOn = open[i]
            viewArray[i]?.setBtn.tag = i
            viewArray[i]?.simpleSwitch.tag = i
            viewArray[i]?.simpleSwitch.addTarget(self, action: #selector(clicksimpleSwitch), for: .valueChanged)
        }
        view1.titleLable.text = "喝水定時"
        view2.titleLable.text = "吃飯定時"
        view3.titleLable.text = "起床時間"
        view4.titleLable.text = "睡覺時間"
    }

    @objc func clicksimpleSwitch(_ sender: UISwitch) {
        let viewArray = [view1, view2, view3, view4]
        let i = sender.tag
        open[i] = sender.isOn
        UserDefaults.standard.set(open, forKey: "open")
        if open[i] != true {
            time[i] = ""
        } else {
            if time[i] == "" {
                time[i] = viewArray[i]?.timeLable.text ?? ""
            }
        }
        UserDefaults.standard.set(time, forKey: "time")
        if time[i] != "" && open[i] == true {
            let view = ShowToastView(frame: UIScreen.main.bounds)
            view.didClickDismissBtnHandler = { }
            self.bgView.addSubview(view)
        }
    }
}
