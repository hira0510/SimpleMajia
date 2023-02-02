//
//  GameViewController.swift
//  Poker
//
//  Created by Hira on 2020/2/5.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var views: GameView!
    let viewModel = GameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        views.takeCardBtn.isUserInteractionEnabled = false
        viewTransform()
        viewModel.allNumber.shuffle()
        viewModel.viewArray = [views.leftView, views.topView, views.rightView]
        viewModel.littleBtnArray = [views.leftBtn, views.topBtn, views.rightBtn]
        viewModel.selfView = views.bottomView
        views.scoreLable.text = "目前點數：0"
    }

    ///洗牌
    @IBAction func shuffleBtnClick(_ sender: Any) {
        views.takeCardBtn.setBackgroundImage(UIImage(named: "pokers"), for: .normal)
        views.takeCardBtn.setTitle("", for: .normal)
        views.takeCardBtn.isUserInteractionEnabled = false
        viewModel.allNumber = []
        for i in 1...52 {
            if !viewModel.takeNumber.contains(i) {
                viewModel.allNumber.append(i)
            }
        }
        viewModel.allNumber.shuffle()
        viewModel.whatCardNum = 20
        if viewModel.whowhowho != viewModel.howhowhow && viewModel.whowhowho != -1 {
            computerPlayCard()
        } else {
            for i in 0...4 {
                viewModel.btnArray[i].isUserInteractionEnabled = true
            }
        }
    }

    ///玩家點擊牌出牌後如果是10orQ
    @IBAction func plusOrLessBtnClick(_ sender: UIButton) {
        views.plusOrLessView.isHidden = true
        views.plusView.isHidden = true
        if sender.tag == 0 {
            viewModel.scoreTitle += viewModel.numberHowMany(allNum: viewModel.takeNumber[viewModel.btnTag * (self.viewModel.howhowhow + 1)], add: false, direction: 3, isComputer: false, isComputerWho: viewModel.btnTag)
        } else {
            viewModel.scoreTitle += viewModel.numberHowMany(allNum: viewModel.takeNumber[viewModel.btnTag * (self.viewModel.howhowhow + 1)], add: true, direction: 3, isComputer: false, isComputerWho: viewModel.btnTag)
        }
        mCardClickfunc(senderTag: viewModel.btnTag)
    }

    ///玩家點擊牌出牌後如果是5
    @IBAction func directionBtnClick(_ sender: UIButton) {
        views.plusOrLessView.isHidden = true
        views.directionView.isHidden = true
        viewModel.scoreTitle += viewModel.numberHowMany(allNum: viewModel.takeNumber[viewModel.btnTag * (self.viewModel.howhowhow + 1)], add: false, direction: sender.tag, isComputer: false, isComputerWho: viewModel.btnTag)
        for i in 0..<self.viewModel.littleBtnArray.count {
            if sender == self.viewModel.littleBtnArray[i] {
                viewModel.whowhowho = i
            }
        }
        mCardClickfunc(senderTag: viewModel.btnTag)
    }

    ///玩家點擊牌出牌
    @IBAction func mCardClick(_ sender: UIButton) {
        viewModel.btnTag = sender.tag
        guard !viewModel.card10andQ.contains(viewModel.takeNumber[viewModel.btnTag * (self.viewModel.howhowhow + 1)]) else {
            views.plusOrLessView.isHidden = false
            views.plusView.isHidden = false
            return
        }
        guard !viewModel.card5.contains(viewModel.takeNumber[viewModel.btnTag * (self.viewModel.howhowhow + 1)]) else {
            views.plusOrLessView.isHidden = false
            views.directionView.isHidden = false
            return
        }
        viewModel.scoreTitle += viewModel.numberHowMany(allNum: viewModel.takeNumber[viewModel.btnTag * (self.viewModel.howhowhow + 1)], add: true, direction: 3, isComputer: false, isComputerWho: viewModel.btnTag)
        mCardClickfunc(senderTag: viewModel.btnTag)
    }

    ///使用者點擊牌
    func mCardClickfunc(senderTag: Int) {
        views.scoreLable.text = "目前點數：\(viewModel.scoreTitle)"
        //Reset
        guard viewModel.scoreTitle <= 99 else {
            resetAll(title: "您輸了！")
            return
        }
        views.lastCard.image = viewModel.btnArray[senderTag].image(for: .normal)
        for i in 0...4 {
            viewModel.btnArray[i].isUserInteractionEnabled = false
            if i >= senderTag && i != 4 {
                viewModel.btnArray[i].setImage(viewModel.btnArray[i + 1].image(for: .normal), for: .normal)
                viewModel.takeNumber[i * (self.viewModel.howhowhow + 1)] = viewModel.takeNumber[(i * (self.viewModel.howhowhow + 1)) + (self.viewModel.howhowhow + 1)]
            } else if i == 4 {
                viewModel.btnArray[4].setImage(UIImage(named: viewModel.dealSuitNumberSet(allNum: viewModel.allNumber[viewModel.whatCardNum])), for: .normal)
                viewModel.takeNumber[(self.viewModel.howhowhow + 1) * i] = viewModel.allNumber[viewModel.whatCardNum]
            }
        }
        viewModel.selfView.backgroundColor = UIColor.clear
        if viewModel.isTurnAround {
            if viewModel.isSpecify == false {
                viewModel.whowhowho = self.viewModel.howhowhow - 1
            }
        } else if viewModel.isTurnAround == false {
            if viewModel.isSpecify == false {
                viewModel.whowhowho = 0
            }
        }
        viewModel.viewArray[viewModel.whowhowho].contentView.backgroundColor = UIColor(red: 250 / 255, green: 255 / 255, blue: 155 / 255, alpha: 1)
        computerPlayCard()
        viewModel.ShuffleCard(takeCardBtn: self.views.takeCardBtn)
    }
    
    ///重置&跳吐司
    func resetAll(title: String) {
        viewModel.gameTimer?.invalidate()
        viewModel.gameTimer = nil
        let vc = viewModel.winToastDisplay(title: title)
        self.view.addSubview(vc)
        viewModel.viewArray = [views.leftView, views.topView, views.rightView]
        viewModel.littleBtnArray = [views.leftBtn, views.topBtn, views.rightBtn]
        self.viewModel.littleBtnArray.forEach { (btn) in
            btn.isEnabled = true
        }
        viewModel.resetGame()
        views.scoreLable.text = "目前點數：0"
        vc.didClickDismissBtnHandler = {
            self.views.dealImg.isHidden = false
            self.viewModel.imgArray.forEach { (imageView) in
                imageView.image = UIImage(named: "")
            }
            self.viewModel.btnArray.forEach { (btn) in
                btn.setImage(UIImage(named: ""), for: .normal)
            }
            self.viewModel.selfView.backgroundColor = UIColor.clear
            self.views.lastCard.image = UIImage(named: "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.views.dealImg.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.dealXibSet()
                }
            }
        }
    }

    ///左右兩家view翻轉&開始發牌
    func viewTransform() {
        let oneDegree = CGFloat.pi / 180
        views.leftView.contentView.transform = CGAffineTransform(rotationAngle: oneDegree * 270)
        views.rightView.contentView.transform = CGAffineTransform(rotationAngle: oneDegree * 90)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.views.dealImg.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.dealXibSet()
            }
        }
    }

    ///假裝發牌的畫面設定
    func dealXibSet() {
        viewModel.imgArray = [views.leftView.image1, views.topView.image1, views.rightView.image1, views.leftView.image2, views.topView.image2, views.rightView.image2, views.leftView.image3, views.topView.image3, views.rightView.image3, views.leftView.image4, views.topView.image4, views.rightView.image4, views.leftView.image5, views.topView.image5, views.rightView.image5]
        viewModel.btnArray = [views.mCard1, views.mCard2, views.mCard3, views.mCard4, views.mCard5]

        var b = 0
        var gameTimer = Timer()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
            if b <= 14 {
                if self.viewModel.whatCardNum % 4 == 0 {
                    self.viewModel.btnArray[b / 3].isHidden = false
                    self.viewModel.btnArray[b / 3].isUserInteractionEnabled = false
                    self.viewModel.btnArray[b / 3].setImage(UIImage(named: self.viewModel.dealSuitNumberSet(allNum: self.viewModel.allNumber[self.viewModel.whatCardNum])), for: .normal)
                } else {
                    self.viewModel.imgArray[b].isHidden = false
                    self.viewModel.imgArray[b].image = UIImage(named: self.viewModel.dealSuitNumberSet(allNum: self.viewModel.allNumber[self.viewModel.whatCardNum]))
                    b += 1
                }
                self.viewModel.takeNumber.append(self.viewModel.allNumber[self.viewModel.whatCardNum])
                self.viewModel.ShuffleCard(takeCardBtn: self.views.takeCardBtn)
            } else {
                gameTimer.invalidate()
                for i in 0..<self.viewModel.btnArray.count {
                    self.viewModel.btnArray[i].isUserInteractionEnabled = true
                }
                self.viewModel.selfView.backgroundColor = UIColor(red: 250 / 255, green: 255 / 255, blue: 155 / 255, alpha: 1)
            }
        })
    }

    ///輪到電腦出牌
    func computerPlayCard() {

        viewModel.gameTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (Timer) in
            let whatcard: [UIImageView] = [self.viewModel.viewArray[self.viewModel.whowhowho].image1, self.viewModel.viewArray[self.viewModel.whowhowho].image2, self.viewModel.viewArray[self.viewModel.whowhowho].image3, self.viewModel.viewArray[self.viewModel.whowhowho].image4, self.viewModel.viewArray[self.viewModel.whowhowho].image5]
            var aaarray: [Int] = []
            var canGo: [Int] = []
            var gogogo: Int = 0
            self.viewModel.isSpecify = false
            
            for i in 0...self.viewModel.howhowhow - 1 {
                self.viewModel.viewArray[i].contentView.backgroundColor = UIColor.clear
            }

            if self.viewModel.whowhowho >= 0 && self.viewModel.whowhowho < self.viewModel.howhowhow {

                for i in 0...4 {
                    aaarray.append(self.viewModel.takeNumber[self.viewModel.whowhowho + 1 + (self.viewModel.howhowhow + 1) * i])
                }

                for i in 0...4 {
                    if self.viewModel.computerCanPlayWhatCard(handCard: aaarray).contains(self.viewModel.takeNumber[self.viewModel.whowhowho + 1 + (self.viewModel.howhowhow + 1) * i]) {
                        canGo.append(self.viewModel.takeNumber[self.viewModel.whowhowho + 1 + (self.viewModel.howhowhow + 1) * i])
                    }
                }
                
                if canGo == [] as! [Int] {
                    print("爆炸！！")
                    
                    for i in (0...4).reversed() {
                        self.viewModel.takeNumber.remove(at: self.viewModel.whowhowho + 1 + (self.viewModel.howhowhow + 1) * i)
                        whatcard[i].image = UIImage(named: "")
                    }
                    
                    self.viewModel.viewArray.remove(at: self.viewModel.whowhowho)
                    self.viewModel.littleBtnArray[self.viewModel.whowhowho].isEnabled = false
                    self.viewModel.littleBtnArray.remove(at: self.viewModel.whowhowho)
                    self.viewModel.howhowhow -= 1
                    guard self.viewModel.howhowhow > 0 else {
                        self.resetAll(title: "恭喜您贏了！")
                        return
                    }
                    self.present(self.viewModel.boomAlert(title: self.viewModel.whowhowho + 1), animated: true, completion: nil)
                    if self.viewModel.isTurnAround == false {
                        self.viewModel.whowhowho -= 1
                    } else {
                        self.viewModel.whowhowho += 1
                    }
                } else {
                    gogogo = canGo.randomElement() ?? 0

                    for i in 0...4 {
                        if self.viewModel.takeNumber[self.viewModel.whowhowho + 1 + (self.viewModel.howhowhow + 1) * i] == gogogo {
                            guard self.viewModel.whatCardNum <= self.viewModel.allNumber.count else { return }
                            self.viewModel.takeNumber[self.viewModel.whowhowho + 1 + (self.viewModel.howhowhow + 1) * i] = self.viewModel.allNumber[self.viewModel.whatCardNum]//更改玩家手上的牌為下一張牌
                            whatcard[i].image = UIImage(named: self.viewModel.dealSuitNumberSet(allNum: self.viewModel.allNumber[self.viewModel.whatCardNum]))//那張牌的image改為下一張牌的image
                        }
                    }
                    self.views.lastCard.image = UIImage(named: self.viewModel.dealSuitNumberSet(allNum: gogogo))//卡池的image改為出的那張牌的image
                    self.viewModel.scoreTitle += self.viewModel.numberHowMany(allNum: gogogo, add: true, direction: 3, isComputer: true, isComputerWho: self.viewModel.whowhowho)//+分數的
                    self.views.scoreLable.text = "目前點數：\(self.viewModel.scoreTitle)"//分數的UI
                }

                if self.viewModel.isTurnAround == false {
                    if self.viewModel.isSpecify == false {
                        self.viewModel.whowhowho += 1
                        self.viewModel.selfView.backgroundColor = UIColor.clear
                    }
                    if self.viewModel.whowhowho >= self.viewModel.howhowhow {
                        self.nextIsMe()
                        self.viewModel.whowhowho = -1
                    } else {
                        self.viewModel.viewArray[self.viewModel.whowhowho].contentView.backgroundColor = UIColor(red: 250 / 255, green: 255 / 255, blue: 155 / 255, alpha: 1)
                        self.viewModel.ShuffleCard(takeCardBtn: self.views.takeCardBtn)//是否要洗牌
                    }
                } else {
                    if self.viewModel.isSpecify == false {
                        self.viewModel.whowhowho -= 1
                        self.viewModel.selfView.backgroundColor = UIColor.clear
                    }
                    if self.viewModel.whowhowho < 0 || self.viewModel.whowhowho == self.viewModel.howhowhow {
                        self.nextIsMe()
                        self.viewModel.whowhowho = self.viewModel.howhowhow - 1
                    } else {
                        self.viewModel.viewArray[self.viewModel.whowhowho].contentView.backgroundColor = UIColor(red: 250 / 255, green: 255 / 255, blue: 155 / 255, alpha: 1)
                        self.viewModel.ShuffleCard(takeCardBtn: self.views.takeCardBtn)//是否要洗牌
                    }
                }
            } else {
                self.nextIsMe()
                self.viewModel.whowhowho = self.viewModel.howhowhow
            }
        })
    }

    ///下一個是玩家
    func nextIsMe() {
        for i in 0...4 {
            self.viewModel.btnArray[i].isUserInteractionEnabled = true
        }
        for i in 0...self.viewModel.howhowhow - 1 {
            self.viewModel.viewArray[i].contentView.backgroundColor = UIColor.clear
        }
        self.viewModel.selfView.backgroundColor = UIColor(red: 250 / 255, green: 255 / 255, blue: 155 / 255, alpha: 1)
        self.viewModel.gameTimer?.invalidate()
        self.viewModel.gameTimer = nil
        self.viewModel.ShuffleCard(takeCardBtn: self.views.takeCardBtn)
    }
}
