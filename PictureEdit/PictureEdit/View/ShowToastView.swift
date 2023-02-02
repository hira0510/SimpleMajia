//
//  ShowToastView.swift
//  PictureEdit
//
//  Created by Hira on 2020/2/11.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class ShowToastView: UIView {

    @IBOutlet var views: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var chooseView: UIView!
    
    var didClickDismissBtnHandler: (() -> Void)? = { }
    var vc: DrawAndSaveViewController?
    
    init(frame: CGRect, type: Int) {
        super.init(frame: frame)
        subviewinit()
        if type == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.removeSelf()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        subviewinit()
    }

    @IBAction func chooseBtn(_ sender: UIButton) {
        let color = [UIColor.lightGray, UIColor.black, UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.white]
        vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrawAndSaveViewController") as? DrawAndSaveViewController
        vc?.color = color[sender.tag]
        removeSelf()
    }
    
    private func subviewinit() {
        Bundle.main.loadNibNamed("ShowToastView", owner: self, options: nil)
        self.addSubview(views)

        views.translatesAutoresizingMaskIntoConstraints = false
        views.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        views.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        views.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        views.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        insideView.layer.cornerRadius = 10
        chooseView.layer.cornerRadius = 10
    }

    ///移除自己
    private func removeSelf() {
        UIView.animate(withDuration: 0.5, animations: {
            self.views.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
            self.didClickDismissBtnHandler?()
        }
    }

}
