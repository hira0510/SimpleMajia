//
//  GameView.swift
//  Poker
//
//  Created by Hira on 2020/2/5.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class GameView: NSObject {
    @IBOutlet weak var leftView: CardView!
    @IBOutlet weak var topView: CardView!
    @IBOutlet weak var rightView: CardView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var plusOrLessView: UIView!
    @IBOutlet weak var plusView: UIView!
    @IBOutlet weak var directionView: UIView!
    @IBOutlet weak var takeCardBtn: UIButton!
    @IBOutlet weak var lastCard: UIImageView!
    @IBOutlet weak var dealImg: UIImageView!
    @IBOutlet weak var scoreLable: UILabel!
    
    @IBOutlet weak var mCard1: UIButton!
    @IBOutlet weak var mCard2: UIButton!
    @IBOutlet weak var mCard3: UIButton!
    @IBOutlet weak var mCard4: UIButton!
    @IBOutlet weak var mCard5: UIButton!
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
}
