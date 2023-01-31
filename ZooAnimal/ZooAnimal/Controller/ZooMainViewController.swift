//
//  ZooMainViewController.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(red: 1, green: 92 / 255, blue: 128 / 255, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor(red: 1, green: 183 / 255, blue: 197 / 255, alpha: 1)
    }
}
