//
//  StartViewController.swift
//  GymTraining
//
//  Created by Hira on 2020/2/21.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class StartViewController: UIViewController {
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var nextLable: UILabel!

    var player: AVPlayer?
    var playerBGM: AVPlayer?

    var timer: Timer?
    var name: [String] = UserDefaults.standard.array(forKey: "name") as? [String] ?? []
    var time: [Int] = UserDefaults.standard.array(forKey: "time") as? [Int] ?? []

    override func viewDidLoad() {
        super.viewDidLoad()
        playTheBGM()
    }

    override func viewWillAppear(_ animated: Bool) {
        guard name.count > 0 else {
            dismiss(animated: true, completion: nil)
            return
        }
        countDown()
    }

    func countDown() {
        var i = 0
        var t = self.time[i]

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.timeLable.text = "\(t) S"
            self.nameLable.text = self.name[i]
            t -= 1
            
            if t < 3 {
                self.playTheSong()
            }

            if i == self.name.count - 1 {
                self.nextLable.text = "做完全部項目囉"
                if t == -1 {
                    self.timer?.invalidate()
                    self.timer = nil
                    let view = ShowToastView(frame: UIScreen.main.bounds)
                    view.didClickDismissBtnHandler = {
                        self.playerBGM?.pause()
                        self.dismiss(animated: true, completion: nil)
                    }
                    self.view.addSubview(view)
                }
            } else {
                self.nextLable.text = "下一個項目是：\(self.name[i + 1])"
                if t == -1 {
                    i += 1
                    t = self.time[i]
                }
            }
        })
    }

    ///播放音樂
    func playTheSong() {
        if let url = Bundle.main.url(forResource: "lol", withExtension: "mp3") {
            player = AVPlayer(url: url)
            self.player?.play()
        }
    }
    
    ///播放音樂
    func playTheBGM() {
        if let url = Bundle.main.url(forResource: "bgm", withExtension: "mp3") {
            playerBGM = AVPlayer(url: url)
            self.playerBGM?.play()
        }
    }

}
