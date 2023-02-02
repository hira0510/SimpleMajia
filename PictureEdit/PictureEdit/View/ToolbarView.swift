//
//  ToolbarView.swift
//  YouDrawIGuess
//
//  Created by Hira on 2020/1/31.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class ToolbarView: UIView {

    @IBOutlet weak var lineWidthSlider: UISlider!
    @IBOutlet weak var eraserBtn: UIButton!
    @IBOutlet weak var cleanBtn: UIButton!
    @IBOutlet weak var grayColorBtn: UIButton!
    @IBOutlet weak var blackColorBtn: UIButton!
    @IBOutlet weak var redColorBtn: UIButton!
    @IBOutlet weak var orangeColorBtn: UIButton!
    @IBOutlet weak var yellowColorBtn: UIButton!
    @IBOutlet weak var greenColorBtn: UIButton!
    @IBOutlet weak var blueColorBtn: UIButton!
    @IBOutlet weak var purpleColorBtn: UIButton!
    
    @IBOutlet var mView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle(for: ToolbarView.self)
        bundle.loadNibNamed("ToolbarView", owner: self, options: nil)
        addSubview(mView!)
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
