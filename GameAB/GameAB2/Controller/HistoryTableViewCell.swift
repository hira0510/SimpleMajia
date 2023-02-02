//
//  HistoryTableViewCell.swift
//  GameAB2
//
//  Created by 王一平 on 2019/7/31.
//  Copyright © 2019 王一平. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var retryTimes: UILabel!
    @IBOutlet weak var times: UILabel!
    @IBOutlet weak var gameresult: UILabel!
    
    override func awakeFromNib() {
            
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configCellWithHistroy(num_:Int , answer_ : String , retryTime_ : String , timer_ : String , date_ : String , times_ : String){
        num.text = "\(num_)"
        answer.text = "正確答案：\(answer_)"
        retryTimes.text = "總次數：\(retryTime_)"
        timer.text = "遊玩時間：\(timer_)"
        date.text = "日期：\(date_)"
        times.text = "你的次數：\(times_)"
    }
    public func configCellWithResult(coler : UIColor , gameresult_ : String ){
        gameresult.textColor = coler
        gameresult.text = "\(gameresult_)"
    }
}
