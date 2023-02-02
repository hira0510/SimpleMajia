//
//  GameStartViewController.swift
//  WhacAMole
//
//  Created by Hira on 2020/2/25.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class GameStartViewController: UIViewController {

    @IBOutlet var views: GameStartView!

    var bgSongPlayer: AVPlayer?
    var soundEffectsPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        views.btnArray = [views.btn0, views.btn1, views.btn2]
        views.img0Array = [views.img0, views.img1, views.img2]
        views.img1Array = [views.img3, views.img4, views.img5]
        views.img2Array = [views.img6, views.img7, views.img8]
        views.img3Array = [views.img9, views.img10, views.img11]
        views.img4Array = [views.img12, views.img13, views.img14]
        views.img5Array = [views.img15, views.img16, views.img17]
    }

    override func viewWillAppear(_ animated: Bool) {
        countDown321()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.bgSongPlayer?.pause()
    }

    @IBAction func btnClick(_ sender: UIButton) {

        let imgArrayArray = [views.img0Array, views.img1Array, views.img2Array, views.img3Array, views.img4Array, views.img5Array]
        if sender.tag == views.whichImg[views.whichRow] {
            playTheSoundEffects(forResource: "stabbing")
            views.score += 1
            for i in 0...5 {
                for j in 0...2 {
                    if i != 5 {
                        imgArrayArray[i][j].image = imgArrayArray[i + 1][j].image
                    } else {
                        guard views.whichRow + 6 != 400 else { return }
                        if j == views.whichImg[views.whichRow + 6] {
                            imgArrayArray[i][j].image = UIImage(named: "cat\(views.whichRow / 50)")
                        } else {
                            imgArrayArray[i][j].image = UIImage(named: "")
                        }
                    }
                }
            }
            views.whichRow += 1
        } else {
            self.views.btnArray.forEach { (btn) in
                btn.isUserInteractionEnabled = false
            }
            var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            playTheSoundEffects(forResource: "shoot2")
            UIView.animate(withDuration: 0.2) {
                imgArrayArray[0].forEach { (img) in
                    frame = img.frame
                    frame.origin.y -= 25
                    img.frame = frame
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIView.animate(withDuration: 0.2) {
                    imgArrayArray[0].forEach { (img) in
                        frame = img.frame
                        frame.origin.y += 25
                        img.frame = frame
                    }
                }
                self.views.btnArray.forEach { (btn) in
                    btn.isUserInteractionEnabled = true
                }
            }
        }
    }

    func imgSet() {
        let num = 0...2
        views.whichImg = []
        views.whichRow = 0
        var whichRow = 0
        for _ in 0...399 {
            views.whichImg.append(num.randomElement()!)
        }
        let imgArrayArray = [views.img0Array, views.img1Array, views.img2Array, views.img3Array, views.img4Array, views.img5Array]
        for i in 0...5 {
            for j in 0...2 {
                if j == views.whichImg[whichRow] {
                    imgArrayArray[i][j].image = UIImage(named: "cat0")
                } else {
                    imgArrayArray[i][j].image = UIImage(named: "")
                }
            }
            whichRow += 1
        }
    }

    func playTheBgSong(forResource: String) {
        if let url = Bundle.main.url(forResource: forResource, withExtension: "mp3") {
            bgSongPlayer = AVPlayer(url: url)
            self.bgSongPlayer?.play()
        }
    }

    func playTheSoundEffects(forResource: String) {
        if let url = Bundle.main.url(forResource: forResource, withExtension: "mp3") {
            soundEffectsPlayer = AVPlayer(url: url)
            self.soundEffectsPlayer?.play()
        }
    }

    func countDown321() {
        var time321: Timer?
        var i = 0
        let imgArray = ["3", "2", "1", "go"]
        let imgArrayArray = [views.img0Array, views.img1Array, views.img2Array, views.img3Array, views.img4Array, views.img5Array]
        self.views.topImg.isHidden = false
        self.views.topImg.image = UIImage(named: "")
        imgArrayArray.forEach { (imgArray) in
            imgArray.forEach { (img) in
                img.image = UIImage(named: "")
            }
        }
        self.views.btnArray.forEach { (btn) in
            btn.isUserInteractionEnabled = false
        }
        time321 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            i += 1
            self.views.topImg.image = UIImage(named: imgArray[i - 1])
            if i == 4 {
                time321?.invalidate()
                time321 = nil
                self.playTheSoundEffects(forResource: "cat_like3a")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.imgSet()
                    self.countDown()
                }
            } else {
                self.playTheSoundEffects(forResource: "cat_like1a")
            }
        })
    }

    func countDown() {
        playTheBgSong(forResource: "[MapleStory BGM] Kerning Square Field")
        views.topImg.isHidden = true
        self.views.btnArray.forEach { (btn) in
            btn.isUserInteractionEnabled = true
        }
        var time = 30
        views.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            time -= 1
            self.views.timeLable.text = "Time: \(time)S"
            if time <= 0 {
                self.views.timer?.invalidate()
                self.views.timer = nil
                self.bgSongPlayer?.pause()
                self.views.score2.append(self.views.score)
                UserDefaults.standard.set(self.views.score2, forKey: "score")
                
                let view = ShowToastView(frame: UIScreen.main.bounds, score: self.views.score)
                view.didClickDismissBtnHandler = {
                    self.dismiss(animated: true, completion: nil)
                }
                view.didClickCarryOnBtnHandler = {
                    self.countDown321()
                    self.views.timeLable.text = "Time: 30S"
                    self.views.score = 0
                }
                self.view.addSubview(view)
            }
        })
    }
}

