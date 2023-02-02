//
//  WhackSecendViewController.swift
//  WhacAMole
//
//  Created by  on 2020/2/25.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class WhackSecendViewController: UIViewController {

    @IBOutlet var views: GameStartView!

    private var bgSongPlayer: AVPlayer?
    private var soundEffectsPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        views.img5Array = [views.img15, views.img16, views.img17]
        views.img4Array = [views.img12, views.img13, views.img14]
        views.img3Array = [views.img9, views.img10, views.img11]
        views.img2Array = [views.img6, views.img7, views.img8]
        views.img1Array = [views.img3, views.img4, views.img5]
        views.img0Array = [views.img0, views.img1, views.img2]
        views.btnArray = [views.btn0, views.btn1, views.btn2]
    }

    override func viewWillAppear(_ animated: Bool) {
        countDown321()
    }

    @IBAction func btnClick(_ sender: UIButton) {

        let imgArrayArray = [views.img0Array, views.img1Array, views.img2Array, views.img3Array, views.img4Array, views.img5Array]
        if sender.tag == views.whichImg[views.whichRow] {
            playTheSoundEffects(forResource: "stab")
            views.score += 1
            for i in 0..<imgArrayArray.count {
                for j in 0...2 {
                    if i != 5 {
                        imgArrayArray[i][j].layer.add(imgAnimate(keyPath: "transform.translation.y", byValue: 4, reverses: false, duration: 0.06, counts: 1, fillMode: CAMediaTimingFillMode.removed), forKey: "true_translation.y")
                        imgArrayArray[i][j].image = imgArrayArray[i + 1][j].image
                    } else {
                        guard views.whichRow + 6 != 320 else { return }
                        if j == views.whichImg[views.whichRow + 6] {
                            imgArrayArray[i][j].image = UIImage(named: "c\(views.whichRow / 40)")
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
            playTheSoundEffects(forResource: "shoot2")
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                imgArrayArray[0].forEach { (img) in
                    img.layer.add(self.imgAnimate(keyPath: "transform.translation.y", byValue: -25, reverses: true, duration: 0.15, counts: 1, fillMode: CAMediaTimingFillMode.forwards), forKey: "false_translation.y")
                }
            }
        }
    }

    private func imgReset() {
        let num = 0...2
        views.whichImg = []
        views.whichRow = 0
        var whichRow = 0
        for _ in 0...399 {
            views.whichImg.append(num.randomElement()!)
        }
        let imgArray = [views.img0Array, views.img1Array, views.img2Array, views.img3Array, views.img4Array, views.img5Array]
        for i in 0..<imgArray.count {
            for j in num {
                if j == views.whichImg[whichRow] {
                    imgArray[i][j].image = UIImage(named: "c0")
                } else {
                    imgArray[i][j].image = UIImage(named: "")
                }
            }
            whichRow += 1
        }
    }

    private func imgAnimate(keyPath: String, byValue: Any, reverses: Bool, duration: TimeInterval, counts: Float, fillMode: CAMediaTimingFillMode) -> CABasicAnimation {
        let mAnimation = CABasicAnimation(keyPath: keyPath)
        mAnimation.byValue = byValue
        mAnimation.duration = duration
        mAnimation.repeatCount = counts
        mAnimation.fillMode = fillMode
        mAnimation.autoreverses = reverses
        mAnimation.delegate = self
        return mAnimation
    }

    private func playTheBgSong(forResource: String) {
        if let url = Bundle.main.url(forResource: forResource, withExtension: "mp3") {
            bgSongPlayer = AVPlayer(url: url)
            self.bgSongPlayer?.play()
        }
    }

    private func playTheSoundEffects(forResource: String) {
        if let url = Bundle.main.url(forResource: forResource, withExtension: "mp3") {
            soundEffectsPlayer = AVPlayer(url: url)
            self.soundEffectsPlayer?.play()
        }
    }

    private func countDown321() {
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
                    self.imgReset()
                    self.countDown()
                }
            } else {
                self.playTheSoundEffects(forResource: "cat_like1a")
            }
        })
    }

    private func countDown() {
        playTheBgSong(forResource: "Kerning Square Field")
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

                let view = ShowToastView(frame: UIScreen.main.bounds, score: self.views.score, time: "")
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

extension WhackSecendViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.views.btnArray.forEach { (btn) in
            btn.isUserInteractionEnabled = true
        }
    }
}
