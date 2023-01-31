//
//  SetTableViewCell.swift
//  GymTraining
//
//  Created by Hira on 2020/2/21.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class SetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib: UINib {
        return UINib(nibName: "SetTableViewCell", bundle: nil)
    }
    
    func configCell(name: String, time: String) {
        nameLable.text = "項目：\(name)"
        timeLable.text = "時間：\(time) S"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
