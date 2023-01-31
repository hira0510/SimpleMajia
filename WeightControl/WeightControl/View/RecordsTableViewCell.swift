//
//  RecordsTableViewCell.swift
//  WeightControl
//
//  Created by  on 2020/2/26.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {


    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var oldLable: UILabel!
    @IBOutlet weak var maleLable: UILabel!
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    @IBOutlet weak var BMILable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static var nib: UINib {
        return UINib(nibName: "RecordsTableViewCell", bundle: nil)
    }

    func configCell(old: Int, male: String, height: Int, weight: Int, times: String, BMI: Float) {
        timeLable.text = "時間：\(times)"
        oldLable.text = "年齡：\(old)"
        maleLable.text = "性別：\(male)"
        heightLable.text = "身高：\(height)"
        weightLable.text = "體重：\(weight)"
        BMILable.text = "BMI：\(BMI)"
    }
}
