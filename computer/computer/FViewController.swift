//
//  ViewController.swift
//  computer
//
//  Created by  on 2020/3/2.
//

import UIKit

enum mode {
    case plus
    case less
    case mult
    case divi
    case defaults
}

class FViewController: UIViewController {

    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var equalBtn: UIButton!

    var numString: String = UserDefaults.standard.string(forKey: "numString") ?? "0"
    var numString2: String = ""
    var mode: mode = .defaults

    override func viewDidLoad() {
        super.viewDidLoad()
        equalBtn.addTarget(self, action: #selector(equalBtnClick), for: .touchUpInside)
        numberLable.text = numString
    }

    @IBAction func numBtnClick(_ sender: UIButton) {

        if (numString.first == "0" && sender.title(for: .normal) != "." && !numString.contains(".")) || (numString2.first == "0" && sender.title(for: .normal) != "." && !numString2.contains(".")) {
            switch mode {
            case .plus:
                numString2 = sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            case .less:
                numString2 = sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            case .mult:
                numString2 = sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            case .divi:
                numString2 = sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            default:
                numString = sender.title(for: .normal) ?? ""
                UserDefaults.standard.set(numString, forKey: "numString")
                numberLable.text = numString
            }
        } else {
            switch mode {
            case .plus:
                numString2 += sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            case .less:
                numString2 += sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            case .mult:
                numString2 += sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            case .divi:
                numString2 += sender.title(for: .normal) ?? ""
                numberLable.text = numString2
            default:
                numString += sender.title(for: .normal) ?? ""
                UserDefaults.standard.set(numString, forKey: "numString")
                numberLable.text = numString
            }
        }
    }

    @IBAction func ACBtnClick(_ sender: UIButton) {
        numString = "0"
        numString2 = ""
        UserDefaults.standard.set("", forKey: "numString")
        numberLable.text = "0"
        mode = .defaults
    }

    @IBAction func CBtnClick(_ sender: UIButton) {
        numString2 = ""
        numberLable.text = "0"
        if mode == .defaults {
            numString = "0"
            UserDefaults.standard.set("0", forKey: "numString")
        }
    }

    @IBAction func functionBtnClick(_ sender: UIButton) {
        if numString2 != "" {
            equalBtnClick()
        }
        if sender.title(for: .normal) == "＋" {
            mode = .plus
        } else if sender.title(for: .normal) == "－" {
            mode = .less
        } else if sender.title(for: .normal) == "ｘ" {
            mode = .mult
        } else {
            mode = .divi
        }
        if numString2 != "" {
            equalBtnClick()
        }
    }

    @objc
    func equalBtnClick() {
        if mode != .defaults {
            var totalNum: Double = 0
            if mode == .plus {
                totalNum = (Double(numString) ?? 0 ) + (Double(numString2) ?? 0 )
            } else if mode == .less {
                totalNum = (Double(numString) ?? 0 ) - (Double(numString2) ?? 0 )
            } else if mode == .mult {
                totalNum = (Double(numString) ?? 0 ) * (Double(numString2) ?? 1 )
            } else if mode == .divi {
                totalNum = (Double(numString) ?? 1 ) / (Double(numString2) ?? 1 )
            }
            var totalNumString = "\(totalNum)"
            
            if totalNum.truncatingRemainder(dividingBy: 1) == 0 {
                totalNumString = String(format: "%.0f", totalNum)
            }
            if totalNumString.count >= 10 {
                totalNumString = String(totalNumString.prefix(10))
            }
            numberLable.text = totalNumString
            UserDefaults.standard.set(totalNumString, forKey: "numString")
            numString = UserDefaults.standard.string(forKey: "numString") ?? ""
            numString2 = ""
        }
    }
}

