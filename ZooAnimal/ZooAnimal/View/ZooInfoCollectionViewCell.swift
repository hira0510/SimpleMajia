//
//  ZooInfoCollectionViewCell.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    
    let zooRequest = ZooRequest()

    static var nib: UINib {
        return UINib(nibName: "ZooInfoCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(img: String) {
        DispatchQueue.main.async {
            guard self.mImageView.image == nil else { return }
            guard let url = URL(string: img) else { return }
            guard let data = try? Data(contentsOf: url) else {
                self.mImageView.image = UIImage(named: "bg-3")
                return
            }
            self.mImageView.image = UIImage(data: data)
        }
    }
}
