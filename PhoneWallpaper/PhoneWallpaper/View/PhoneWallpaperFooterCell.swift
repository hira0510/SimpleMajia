//
//  PhoneWallpaperFooterCell.swift
//  PhoneWallpaper
//
//  Created by  on 2021/9/28.
//

import UIKit

class PhoneWallpaperFooterCell: UICollectionReusableView {

    @IBOutlet weak var changeButton: UIButton!
    
    static var nib: UINib {
        return UINib(nibName: "PhoneWallpaperFooterCell", bundle: nil)
    }
    
    var didClickChangeBtn: (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeButton.layer.cornerRadius = changeButton.frame.height / 2
        changeButton.layer.borderWidth = 2
        changeButton.layer.borderColor = #colorLiteral(red: 0.4352941176, green: 0.3450980392, blue: 1, alpha: 1)
        changeButton.addTarget(self, action: #selector(didClickBtn), for: .touchUpInside)
    }
    
    @objc func didClickBtn() {
        didClickChangeBtn()
    }
}
