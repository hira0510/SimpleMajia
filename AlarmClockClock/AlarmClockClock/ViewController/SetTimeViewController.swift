//
//  SetTimeViewController.swift
//  AlarmClockClock
//
//  Created by Hira on 2020/2/12.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class SetTimeViewController: UIViewController {

    @IBOutlet var views: SetTimeView!

    var which: Int = 0
    var open: [Bool] = (UserDefaults.standard.array(forKey: "open") as? [Bool])!
    var time: [String] = (UserDefaults.standard.array(forKey: "time") as? [String])!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        views.setViewController(which: which, open: open[which])
        
    }

    @IBAction func switchChange(_ sender: UISwitch) {
        open[which] = sender.isOn
        UserDefaults.standard.set(open, forKey: "open")
    }
    
    @IBAction func timeChange(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.string(from: sender.date)
        time[which] = date
    }
    
    @IBAction func completeBtnClick(_ sender: UIButton) {
        if open[which] != true {
            time[which] = ""
            self.dismiss(animated: true, completion: nil)
        }
        UserDefaults.standard.set(time, forKey: "time")
        if time[which] != "" && open[which] == true {
            let view = ShowToastView(frame: UIScreen.main.bounds)
            view.didClickDismissBtnHandler = {
                self.dismiss(animated: true, completion: nil)
            }
            self.view.addSubview(view)
        }
    }
}
