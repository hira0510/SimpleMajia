//
//  WinToastView.swift
//  Poker
//
//  Created by Hira on 2020/2/10.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class WinToastView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var didClickDismissBtnHandler: (() -> Void)? = { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        remove()
        didClickDismissBtnHandler?()
    }
    
    private func remove() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func common() {
        Bundle.main.loadNibNamed("WinToastView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
