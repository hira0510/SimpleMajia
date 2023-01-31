//
//  PhoneWallpaperCollectionViewCell.swift
//  PhoneWallpaper
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class PhoneWallpaperCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    var mImageData: Data?
    
    static var nib: UINib {
        return UINib(nibName: "PhoneWallpaperCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(img: Data?) {
        guard let data = img else {
            self.mImageView.image = UIImage(named: "bg")
            self.mImageView.alpha = 0.3
            return
        }
        guard mImageData != data else { return }
        self.mImageData = data
        self.mImageView.alpha = 1
        self.mImageView.image = UIImage(data: data)
    }
}
