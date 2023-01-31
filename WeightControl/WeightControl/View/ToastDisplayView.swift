//
//  ToastDisplayView.swift
//
//  Created by  on 2020/2/26.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class ToastDisplayView: UIView {

    @IBOutlet var mView: UIView!
    @IBOutlet weak var views: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var BMILable: UILabel!
    @IBOutlet weak var SoLable: UILabel!
    
    var dismissBtnHandler: (() -> Void)? = { }
    
    init(frame: CGRect, BMI: Float, old: Int, male: String) {
        super.init(frame: frame)
        viewinit()
        BMILable.text = "BMI：\(BMI)"
        nonsense(BMI: BMI, old: old, male: male)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewinit()
    }
    @IBAction func okBtnClick(_ sender: UIButton) {
        self.remove()
    }

    private func viewinit() {
        Bundle.main.loadNibNamed("ToastDisplayView", owner: self, options: nil)
        self.addSubview(mView)

        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        views.layer.cornerRadius = 11
    }
    
    func nonsense(BMI: Float, old: Int, male: String) {
        if old <= 12 {
            if BMI < 18.5 {
                imgView.image = UIImage(named: "omg1")
                SoLable.text = "上帝：小時了了，大未必佳"
            } else if BMI >= 18.5 && BMI < 24 {
                imgView.image = UIImage(named: "omg2")
                SoLable.text = "上帝：還能吃，還在發育"
            } else {
                imgView.image = UIImage(named: "omg3")
                SoLable.text = "上帝：長胖不一定長高"
            }
        } else if old > 12 && old <= 25 {
            if BMI < 18.5 {
                imgView.image = UIImage(named: "omg1")
                if male == "男" {
                    SoLable.text = "上帝：壯壯的才會受歡迎唷"
                } else {
                    SoLable.text = "上帝：你可以再多吃點"
                }
            } else if BMI >= 18.5 && BMI < 24 {
                imgView.image = UIImage(named: "omg2")
                if male == "男" {
                    SoLable.text = "上帝：現在這身材都剛好唷"
                } else {
                    SoLable.text = "上帝：引人犯罪？"
                }
            } else {
                imgView.image = UIImage(named: "omg3")
                if male == "男" {
                    SoLable.text = "上帝：長過頭了吧"
                } else {
                    SoLable.text = "上帝：有點太胖了吧...."
                }
            }
        } else if old > 25 && old <= 50 {
            if BMI < 18.5 {
                imgView.image = UIImage(named: "omg1")
                if male == "男" {
                    SoLable.text = "上帝：公司虐待你嗎?"
                } else {
                    SoLable.text = "上帝：不要再減肥了"
                }
            } else if BMI >= 18.5 && BMI < 24 {
                imgView.image = UIImage(named: "omg2")
                if male == "男" {
                    SoLable.text = "上帝：哇賽人帥真好"
                } else {
                    SoLable.text = "上帝：去品嚐各式美食吧！"
                }
            } else {
                imgView.image = UIImage(named: "omg3")
                if male == "男" {
                    SoLable.text = "上帝：現在運動還來得及！"
                } else {
                    SoLable.text = "上帝：減肥永遠是明天的事！"
                }
            }
        } else {
            if BMI < 18.5 {
                imgView.image = UIImage(named: "omg1")
                if male == "男" {
                    SoLable.text = "上帝：瘦皮猴?"
                } else {
                    SoLable.text = "上帝：多吃才會長壽啦"
                }
            } else if BMI >= 18.5 && BMI < 24 {
                imgView.image = UIImage(named: "omg2")
                if male == "男" {
                    SoLable.text = "上帝：哎唷不錯唷"
                } else {
                    SoLable.text = "上帝：小心吃太多走樣..."
                }
            } else {
                imgView.image = UIImage(named: "omg3")
                if male == "男" {
                    SoLable.text = "上帝：這樣會讓人擔心唷"
                } else {
                    SoLable.text = "上帝：這樣對健康不好喔"
                }
            }
        }
    }

    private func remove() {
        self.removeFromSuperview()
        self.dismissBtnHandler?()
    }
}
