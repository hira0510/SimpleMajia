//
//  DrawAndSaveViewController.swift
//  PictureEdit
//
//  Created by Hira on 2020/2/24.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class DrawAndSaveViewController: UIViewController {

    @IBOutlet var views: PhotoDrawAndSaveView!
    
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        views.setupToolbarViewXib()
        views.drawView.backgroundColor = color
        views.btnArray.forEach { (btn) in
            if btn.backgroundColor == color {
                btn.backgroundColor = UIColor.white
            }
        }
    }

    @IBAction func backBtnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func save(sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(capture(), nil, nil, nil)
        let view = ShowToastView(frame: UIScreen.main.bounds, type: 1)
        view.chooseView.isHidden = true
        view.didClickDismissBtnHandler = {
            self.dismiss(animated: true, completion: nil)
        }
        self.view.addSubview(view)
    }
    
    func capture() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.views.drawView.frame.size, self.views.drawView.isOpaque, UIScreen.main.scale)
        self.views.drawView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
