//
//  ViewController.swift
//  GameAB2
//
//  Created by 王一平 on 2019/7/15.
//  Copyright © 2019 王一平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //首頁的開始提視窗與跳轉到遊戲畫面
    @IBAction func playBtnPressed(_ sender: UIButton) {
        let hito = UIAlertController(title: "遊戲玩法:", message: "玩家總共有1~15次機會，\n請玩家輸入4個不同數字，\n數字及位置都對得一個Ａ，\n數字對但位置不同得一個B\n答案完全相同時(4A0B)，\n即可過關", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default) {(UIAlertAction) in
            self.performSegue(withIdentifier: "ToPlayViewController" , sender: nil)
        }
        hito.addAction(ok)
        self.present(hito, animated: true, completion: nil)
    }
}
