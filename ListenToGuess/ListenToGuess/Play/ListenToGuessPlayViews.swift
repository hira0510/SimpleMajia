//
//  ListenToGuessPlayViews.swift
//  ListenToGuess
//
//  Created by  on 2021/11/25.
//

import UIKit
import Lottie

class ListenToGuessPlayViews: NSObject {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var ans0Label: UILabel!
    @IBOutlet weak var ans1Label: UILabel!
    @IBOutlet weak var ans2Label: UILabel!
    @IBOutlet weak var ans3Label: UILabel!
    
    @IBOutlet weak var ans0Btn: UIButton!
    @IBOutlet weak var ans1Btn: UIButton!
    @IBOutlet weak var ans2Btn: UIButton!
    @IBOutlet weak var ans3Btn: UIButton!
    
    @IBOutlet weak var ans0View: UIView!
    @IBOutlet weak var ans1View: UIView!
    @IBOutlet weak var ans2View: UIView!
    @IBOutlet weak var ans3View: UIView!
    
    public var lblArray: [UILabel] = []
    public var btnArray: [UIButton] = []
    public var viewArray: [UIView] = []
    
    public var animationView: AnimationView = {
        let animationView = AnimationView(name: "lives")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleToFill
        return animationView
    }()
    
    public func setViewNotSelect() {
        animationView.play()
        
        viewArray.forEach { view in
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 2
            view.layer.borderColor = #colorLiteral(red: 0.2455570248, green: 0.5216013235, blue: 0.4902975443, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.826766541, green: 1, blue: 0.8495325475, alpha: 0.498754177)
            view.isUserInteractionEnabled = true
        }
    }
    
    public func setViewSelectTrue(index: Int) {
        viewArray[index].layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9960784314, blue: 0.3960784314, alpha: 0)
        viewArray[index].backgroundColor = #colorLiteral(red: 0.6152273325, green: 0.9311130764, blue: 0.5839233398, alpha: 1)
        
        viewArray.forEach { view in
            view.isUserInteractionEnabled = false
        }
    }
    
    public func setViewSelectFalse(select: Int, ans: Int) {
        viewArray[select].layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9960784314, blue: 0.3960784314, alpha: 0)
        viewArray[select].backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.3492689866, blue: 0.5300648296, alpha: 1)
        viewArray[ans].layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9960784314, blue: 0.3960784314, alpha: 0)
        viewArray[ans].backgroundColor = #colorLiteral(red: 0.6152273325, green: 0.9311130764, blue: 0.5839233398, alpha: 1)
        
        viewArray.forEach { view in
            view.isUserInteractionEnabled = false
        }
    }
}
