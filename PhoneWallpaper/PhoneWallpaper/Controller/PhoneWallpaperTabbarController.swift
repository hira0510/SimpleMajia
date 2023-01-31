//
//  PhoneWallpaperTabbarController.swift
//  PhoneWallpaper
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class PhoneWallpaperTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = #colorLiteral(red: 0.5725490196, green: 0.5647058824, blue: 1, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.5725490196, green: 0.7921568627, blue: 1, alpha: 1)
    }
}
