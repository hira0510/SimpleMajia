//
//  ZooFirstCollectionViewCell.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooFirstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mLabel: UILabel!

    let zooRequest = ZooRequest()
    var str = ""
    static var nib: UINib {
        return UINib(nibName: "ZooFirstCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(name: String, img: Data?) {
        mLabel.text = name
        guard let data = img else {
            self.mImageView.image = UIImage(named: "bg-3")
            return
        }
        self.mImageView.image = UIImage(data: data)
    }
}
