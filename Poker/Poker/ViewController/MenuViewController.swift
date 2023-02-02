//
//  MenuViewController.swift
//  Poker
//
//  Created by Hira on 2020/2/5.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func explainClick(_ sender: UIButton) {
        let rule = UIAlertController(title: "99遊戲說明", message: "黑桃1為歸0，4為迴轉，5為指定，10為+-10點，J為Pass，Q為+-20，K為99，其餘牌數則是依據牌的數字來增加，能留到最後一個就贏了，如果點數超過99則判斷為輸了。", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default, handler: nil)
        rule.addAction(ok)
        self.present(rule, animated: true, completion: nil)
    }
    
}

