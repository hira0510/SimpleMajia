//
//  MenuView.swift
//  AlarmClockClock
//
//  Created by Hira on 2020/2/13.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class MenuView: UIView {

    @IBOutlet var views: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var simpleSwitch: UISwitch!
    @IBOutlet weak var setBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MenuView", owner: self, options: nil)
        self.addSubview(views)
        views.translatesAutoresizingMaskIntoConstraints = false
        views.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        views.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        views.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        views.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
