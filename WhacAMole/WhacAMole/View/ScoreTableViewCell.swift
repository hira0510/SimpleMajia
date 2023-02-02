//
//  ScoreTableViewCell.swift
//  WhacAMole
//
//  Created by Hira on 2020/2/25.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var scoreLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static var nib: UINib {
        return UINib(nibName: "ScoreTableViewCell", bundle: nil)
    }
    
    func configCell(score: Int) {
        scoreLable.text = "点数：\(score)"
        let img = score / 50
        catImg.image = UIImage(named: "cat\(img)")
    }
}
