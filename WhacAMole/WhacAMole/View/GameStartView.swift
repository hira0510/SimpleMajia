//
//  GameStartView.swift
//  WhacAMole
//
//  Created by Hira on 2020/2/25.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class GameStartView: NSObject {

    @IBOutlet weak var img0: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img9: UIImageView!
    @IBOutlet weak var img10: UIImageView!
    @IBOutlet weak var img11: UIImageView!
    @IBOutlet weak var img12: UIImageView!
    @IBOutlet weak var img13: UIImageView!
    @IBOutlet weak var img14: UIImageView!
    @IBOutlet weak var img15: UIImageView!
    @IBOutlet weak var img16: UIImageView!
    @IBOutlet weak var img17: UIImageView!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var topImg: UIImageView!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    var btnArray: [UIButton] = []
    var img0Array: [UIImageView] = []
    var img1Array: [UIImageView] = []
    var img2Array: [UIImageView] = []
    var img3Array: [UIImageView] = []
    var img4Array: [UIImageView] = []
    var img5Array: [UIImageView] = []
    var whichImg: [Int] = []
    var whichRow: Int = 0
    var score: Int = 0
    var timer: Timer?
    var score2: [Int] = UserDefaults.standard.array(forKey: "score") as? [Int] ?? []
}
