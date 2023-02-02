//
//  GameViewModel.swift
//  Poker
//
//  Created by Hira on 2020/2/5.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class GameViewModel {

    ///花色
    let suits: [String] = ["spade", "heart", "diamond", "club"]
    ///數字
    let number: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
    ///UIImage陣列
    var imgArray: [UIImageView] = []
    ///UIButton陣列
    var btnArray: [UIButton] = []
    ///UIView陣列
    var viewArray: [CardView] = []
    ///UIButton陣列
    var littleBtnArray: [UIButton] = []
    ///selfView
    var selfView: UIView = UIView()
    ///計時器
    var gameTimer: Timer?
    ///玩家手上的牌
    var takeNumber: [Int] = []
    ///剩餘的牌
    var allNumber: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52]
    ///第幾張牌
    var whatCardNum: Int = 0
    ///分數的總和
    var scoreTitle: Int = 0
    ///4的index位置
    var card4: [Int] = [4, 17, 30, 43]
    ///5的index位置
    var card5: [Int] = [5, 18, 31, 44]
    ///10&Q的index位置
    var card10andQ: [Int] = [10, 23, 36, 49, 12, 25, 38, 51]
    ///使用者點擊btn的tag
    var btnTag: Int = 0
    ///到底誰出牌的
    var whowhowho: Int = 0
    ///到底pc剩幾個人
    var howhowhow: Int = 3
    ///是否是迴轉
    var isTurnAround: Bool = false
    ///是否是指定
    var isSpecify: Bool = false
    
    ///發牌花色數字設定
    func dealSuitNumberSet(allNum: Int) -> String {
        var suit = ""
        var num = ""
        switch allNum / 14 {
        case 0:
            suit = suits[0]
        case 1:
            suit = suits[1]
        case 2:
            suit = suits[2]
        default:
            suit = suits[3]
        }
        if allNum % 13 == 0 {
            num = "13"
        } else {
            num = "\(allNum % 13)"
        }
        return "\(suit)_\(num)"
    }

    ///數字為多少(計分用)
    ///
    /// - Parameter allNum: 1~52的數字
    /// - Parameter add: 10&Q true-> +, false-> -
    /// - Parameter direction: 5指定誰0~3 3是自己
    /// - Parameter isComputer: 是否是電腦
    /// - Parameter isComputerWho: 電腦的哪個玩家
    /// - Returns: 回傳分數
    func numberHowMany(allNum: Int, add: Bool, direction: Int, isComputer: Bool, isComputerWho: Int) -> Int {
        switch allNum % 13 {
        case 0:
            scoreTitle = 99
            return 0
        case 1:
            if allNum == 1 {
                scoreTitle = 0
                return 0
            } else {
                return 1
            }
        case 4:
            isTurnAround = !isTurnAround
            return 0
        case 5:
            if isComputer {
                whowhowho = Int.random(in: 0...howhowhow)
                while whowhowho == isComputerWho {
                    whowhowho = Int.random(in: 0...howhowhow)
                }
                for i in 0...howhowhow - 1 {
                    viewArray[i].contentView.backgroundColor = UIColor.clear
                }
                if whowhowho <= howhowhow - 1 {
                    viewArray[whowhowho].contentView.backgroundColor = UIColor(red: 250 / 255, green: 255 / 255, blue: 155 / 255, alpha: 1)
                    selfView.backgroundColor = UIColor.clear
                }
            } else {
                whowhowho = direction
            }
            isSpecify = true
            return 0
        case 10:
            if isComputer {
                if scoreTitle <= 89 {
                    return 10
                } else {
                    if scoreTitle >= 10 {
                        return -10
                    } else {
                        return -scoreTitle
                    }
                }
            } else {
                if add {
                    return 10
                } else {
                    if scoreTitle >= 10 {
                        return -10
                    } else {
                        return -scoreTitle
                    }
                }
            }
        case 11:
            return 0
        case 12:
            if isComputer {
                if scoreTitle <= 79 {
                    return 20
                } else {
                    if scoreTitle >= 20 {
                        return -20
                    } else {
                        return -scoreTitle
                    }
                }
            } else {
                if add {
                    return 20
                } else {
                    if scoreTitle >= 20 {
                        return -20
                    } else {
                        return -scoreTitle
                    }
                }
            }
        default:
            return allNum % 13
        }
    }

    ///何時該洗牌
    func ShuffleCard(takeCardBtn: UIButton) {
        whatCardNum += 1
        if whatCardNum == allNumber.count {
            gameTimer?.invalidate()
            gameTimer = nil
            takeCardBtn.setBackgroundImage(UIImage(named: ""), for: .normal)
            takeCardBtn.setTitle("洗牌", for: .normal)
            takeCardBtn.isUserInteractionEnabled = true
            for i in 0...4 {
                self.btnArray[i].isUserInteractionEnabled = false
            }
        }
    }

    ///電腦可以出什麼牌
    func computerCanPlayWhatCard(handCard: [Int]) -> [Int] {
        //黑桃1,4 5 10 j q k
        var array: [Int] = [1, 4, 17, 30, 43, 5, 18, 31, 44, 10, 23, 36, 49, 11, 24, 37, 50, 12, 25, 38, 51, 13, 26, 39, 52]
        for i in 0...4 {
            if handCard[i] % 13 <= 99 - scoreTitle {
                if handCard[i] % 13 != 0 {
                    for j in 0...3 {
                        array.append(handCard[i] % 13 + 13 * j)
                    }
                }
            }
        }
        return array
    }
    
    func winToastDisplay(title: String) -> WinToastView {
        let view = WinToastView(frame: UIScreen.main.bounds)
        view.titleLable.text = title
        return view
    }
    
    func boomAlert(title: Int) -> UIAlertController {
        let rule = UIAlertController(title: "Boom!!!", message: "電腦\(title)已爆炸!!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default, handler: nil)
        rule.addAction(ok)
        return rule
    }
    
    func resetGame() {
        scoreTitle = 0
        takeNumber = []
        allNumber.append(Int.random(in: 1...52))
        allNumber.shuffle()
        whatCardNum = 0
        whowhowho = 0
        howhowhow = 3
        isTurnAround = false
        isSpecify = false
    }
}
