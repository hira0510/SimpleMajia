//
//  MenuViewController.swift
//  AlarmClockClock
//
//  Created by Hira on 2020/2/12.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MenuViewController: UIViewController {

    @IBOutlet var views: MenuViews!
    var player: AVQueuePlayer = AVQueuePlayer()
    var playerItem: AVPlayerItem?
    var looper: AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(views.open, forKey: "open")
        UserDefaults.standard.set(views.time, forKey: "time")
        music()
        views.view1.setBtn.addTarget(self, action: #selector(clickSetBtn), for: .touchUpInside)
        views.view2.setBtn.addTarget(self, action: #selector(clickSetBtn), for: .touchUpInside)
        views.view3.setBtn.addTarget(self, action: #selector(clickSetBtn), for: .touchUpInside)
        views.view4.setBtn.addTarget(self, action: #selector(clickSetBtn), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        views.open = (UserDefaults.standard.array(forKey: "open") as? [Bool])!
        views.time = (UserDefaults.standard.array(forKey: "time") as? [String])!
        views.setViews()
    }

    ///跳轉到設置頁
    @objc func clickSetBtn(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetTimeViewController") as! SetTimeViewController
        vc.which = sender.tag
        self.player.pause()
        present(vc, animated: true, completion: nil)
    }

    ///計時器
    func music() {
        views.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            for i in 0...1 {
                if self.views.open[i] {
                    self.views.timing[i] += 1
                }
            }
            self.setTime()
        })
    }

    ///是否播放音樂
    func setTime() {
        //現在時間
        let dates = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: dates as Date)

        //定時(起床睡覺)
        for i in 2...3 {
            if self.views.open[i] == true && views.time[i] != "" {
                if date == views.time[i] {
                    let str = i == 2 ? "起床了啦！" : "快點睡覺別玩了！"
                    showClose(title: str, i: i)
                }
            }
        }
        //計時(吃飯喝水)
        for i in 0...1 {
            let timeString = String(format: "%02d:%02d", views.timing[i] / 3600, (views.timing[i] / 60) % 60)
            if self.views.open[i] == true && timeString >= views.time[i] && views.time[i] != "00:00" {
                if self.views.timing[i] >= 60 {
                    self.views.timing[i] = 0
                }
                let str = i == 0 ? "喝水囉～" : "吃飯了！"
                showClose(title: str, i: i)
            }
        }
    }

    ///播放音樂
    func playTheSong(which: Int) {
        if let url = Bundle.main.url(forResource: views.songNum[which], withExtension: "mp3") {
            playerItem = AVPlayerItem(url: url)
            looper = AVPlayerLooper(player: player, templateItem: AVPlayerItem(url: url))
        }
    }

    func showClose(title: String, i: Int) {
        views.timer?.invalidate()
        views.timer = nil
        playTheSong(which: i)
        player.play()
        var t = Timer()
        if player.rate > 0 {
            t = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
                for i in 0...1 {
                    if self.views.open[i] {
                        self.views.timing[i] += 1
                    }
                }
            })
        }
        let rule = UIAlertController(title: title, message: "請按確認來停止", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default) { (UIAlertAction) in
            t.invalidate()
            self.player.pause()
            DispatchQueue.main.asyncAfter(deadline: .now() + 59) {
                self.views.open[i] = true
            }
            self.views.open[i] = false
            self.music()
        }
        rule.addAction(ok)
        self.present(rule, animated: true, completion: nil)
    }
}
