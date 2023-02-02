//
//  SecendSameView.swift
//  SameCard
//
//  Created by  on 2020/3/3.
//

import UIKit

class SecendSameView: NSObject {

    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn10: UIButton!
    @IBOutlet weak var btn11: UIButton!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn13: UIButton!
    @IBOutlet weak var btn14: UIButton!
    @IBOutlet weak var btn15: UIButton!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var maskView: UIView!
    
    var cardRandomNum: [String] = ["c0", "c0", "c1", "c1", "c2", "c2", "c3", "c3", "c4", "c4", "c5", "c5", "c6", "c6", "c7", "c7"]
    var btnArray: [UIButton] = []
    var timer: Timer?
    var times: Int = 0
    var isOpenCard: Bool = false
    var previousNum: Int = 0
}
