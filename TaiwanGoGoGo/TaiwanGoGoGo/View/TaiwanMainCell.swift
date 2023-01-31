//
//  TaiwanMainCell.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/27.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class TaiwanMainCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    static var nib: UINib {
        return UINib(nibName: "TaiwanMainCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    internal func configCell(image: String, title: String, address: String) {
        if image == "" {
            mImageView.image = UIImage(named: "noImage")
        } else {
            if let url = URL(string: image) {
                DispatchQueue.main.async {
                    UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "noImage"), options: nil, progressBlock: nil) { (result) in
                        switch result {
                        case .success(let success):
                            self.mImageView.image = success.image
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
        titleLabel.text = title
        addressLabel.text = address
    }
}
