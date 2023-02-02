//
//  GameOverView.swift
//  ListenToGuess
//
//  Created by Hira on 2021/11/25.
//

import UIKit

class ListenToGuessModel {
    var mTime: String = ""
    var mScore: String = ""
    
    init (time: String, score: String) {
        mTime = time
        mScore = score
    }
}

class GameOverView: UIView {
    
    @IBOutlet var mView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    private var mScore: Int = 0
    internal var clickRemoveBtnHandler: (() -> Void)? = { }
    internal var clickRestratBtnHandler: (() -> Void)? = { }
    
    init(frame: CGRect, score: Int) {
        super.init(frame: frame)
        mScore = score
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("GameOverView", owner: self, options: nil)
        addSubview(mView!)
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        removeButton.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartBtn), for: .touchUpInside)
        bgView.layer.cornerRadius = 10
        removeButton.layer.cornerRadius = 10
        restartButton.layer.cornerRadius = 10
        textLabel.text = "GET\n\(mScore)/100"
        
        let date: Date = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatStr = String(dateFormat.string(from: date))
        
        var time = UserDefaults.standard.stringArray(forKey: "ListenToGuessModelTime") ?? []
        var score = UserDefaults.standard.stringArray(forKey: "ListenToGuessModelScore") ?? []
        time.insert(dateFormatStr, at: 0)
        score.insert(String(mScore), at: 0)
        UserDefaults.standard.set(time, forKey: "ListenToGuessModelTime")
        UserDefaults.standard.set(score, forKey: "ListenToGuessModelScore")
    }
    
    @objc private func backBtn() {
        clickRemoveBtnHandler?()
        self.removeFromSuperview()
    }
    
    @objc private func restartBtn() {
        clickRestratBtnHandler?()
        self.removeFromSuperview()
    }
}
