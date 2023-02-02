//
//  SameSecendViewController.swift
//  SameCard
//
//  Created by  on 2020/3/3.
//

import UIKit
import AVFoundation
import MediaPlayer

class SameSecendViewController: UIViewController {

    @IBOutlet var mView: SecendSameView!

    var play: AVQueuePlayer = AVQueuePlayer()
    var effectsPlayer: AVPlayer?
    var pItem: AVPlayerItem?
    var loop: AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()
        mView.btnArray = [mView.btn0, mView.btn1, mView.btn2, mView.btn3, mView.btn4, mView.btn5, mView.btn6, mView.btn7, mView.btn8, mView.btn9, mView.btn10, mView.btn11, mView.btn12, mView.btn13, mView.btn14, mView.btn15]
    }

    override func viewDidAppear(_ animated: Bool) {
        reload()
    }

    @IBAction func cardBtnDidClick(_ sender: UIButton) {
        UIView.transition(with: sender, duration: 0.2, options: [.transitionFlipFromLeft], animations: {
            sender.setImage(UIImage(named: self.mView.cardRandomNum[sender.tag]), for: .normal)
        }, completion: nil)
        playTheSoundEffects(forResource: "stab")
        sender.isUserInteractionEnabled = false

        guard mView.isOpenCard else { //如果沒有牌是翻開的->就翻開
            mView.isOpenCard = true
            mView.previousNum = sender.tag
            return
        }

        //如果有牌是翻開的
        if mView.btnArray[mView.previousNum].image(for: .normal) == sender.image(for: .normal) && mView.previousNum != sender.tag {
            //如果上次翻的牌等於現在翻的牌&&牌面上的那張牌不等於現在翻的牌->達對
            mView.isOpenCard = false
            var count = 0
            mView.btnArray.forEach { (btn) in
                if btn.image(for: .normal) != UIImage(named: "card_cat_bg") {
                    count += 1
                    if count == 16 {
                        play.pause()
                        self.mView.timer?.invalidate()
                        self.mView.timer = nil
                        var time = UserDefaults.standard.array(forKey: "time") ?? []
                        time.append("\(mView.times)")
                        UserDefaults.standard.set(time, forKey: "time")
                        let view = ShowToastView(frame: UIScreen.main.bounds, score: 0, time: "\(mView.times)")
                        view.didClickDismissBtnHandler = {
                            self.dismiss(animated: true, completion: nil)
                        }
                        view.didClickCarryOnBtnHandler = {
                            self.reload()
                        }
                        self.view.addSubview(view)
                    }
                }
            }
        } else {
            //->答錯
            mView.maskView.isHidden = false
            mView.isOpenCard = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.transition(with: sender, duration: 0.2, options: [.transitionFlipFromRight], animations: {
                    sender.setImage(UIImage(named: "card_cat_bg"), for: .normal)
                    self.mView.btnArray[self.mView.previousNum].setImage(UIImage(named: "card_cat_bg"), for: .normal)
                }, completion: nil)
                self.mView.btnArray[self.mView.previousNum].isUserInteractionEnabled = true
                sender.isUserInteractionEnabled = true
                self.mView.maskView.isHidden = true
            }
        }
    }

    func bgSong() {
        if let url = Bundle.main.url(forResource: "Ellinia", withExtension: "mp3") {
            pItem = AVPlayerItem(url: url)
            loop = AVPlayerLooper(player: play, templateItem: AVPlayerItem(url: url))
            play.play()
        }
    }

    func playTheSoundEffects(forResource: String) {
        if let url = Bundle.main.url(forResource: forResource, withExtension: "mp3") {
            effectsPlayer = AVPlayer(url: url)
            self.effectsPlayer?.play()
        }
    }

    func start() {
        mView.timeTitle.text = "時間：\(self.mView.times)s"
        mView.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.mView.times += 1
            self.mView.timeTitle.text = "時間：\(self.mView.times)s"
        })
    }

    func reload() {
        mView.times = 0
        mView.timeTitle.text = "Time： s"
        mView.cardRandomNum.shuffle()
        mView.maskView.isHidden = false
        for i in 0..<mView.btnArray.count {
            UIView.transition(with: mView.btnArray[i], duration: 0.2, options: [.transitionFlipFromLeft], animations: {
                self.mView.btnArray[i].setImage(UIImage(named: self.mView.cardRandomNum[i]), for: .normal)
            }, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.bgSong()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mView.btnArray.forEach { (btn) in
                btn.isUserInteractionEnabled = true
                for i in 0..<self.mView.btnArray.count {
                    UIView.transition(with: self.mView.btnArray[i], duration: 0.2, options: [.transitionFlipFromRight], animations: {
                        self.mView.btnArray[i].setImage(UIImage(named: "card_cat_bg"), for: .normal)
                    }, completion: nil)
                }
            }
            self.mView.maskView.isHidden = true
            self.start()
        }
    }
}
