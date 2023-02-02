//
//  GamesViewModel.swift
//  ChildMemory
//
//  Created by  on 2021/3/12.
//

import UIKit

class GamesViewModel: NSObject {
    
    var gameTimer: Timer?
    var btnArray: [UIButton] = []
    var imageArray: [String] = ["Image-0", "Image-1", "Image-2", "Image-3", "Image-4", "Image-5", "Image-6", "Image-7", "Image-8", "Image-9", "Image-10", "Image-11", "Image-12", "Image-13", "Image-14", "Image-15", "Image-16", "Image-17", "Image-18", "Image-19", "Image-20"]
    var isOpen: Bool = false
    var pNum: Int = 0
    var lag: Bool = false

}
