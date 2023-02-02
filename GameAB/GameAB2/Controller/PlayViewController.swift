//
//  PlayViewController.swift
//  GameAB2
//
//  Created by 王一平 on 2019/7/15.
//  Copyright © 2019 王一平. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var count = 0
    var times = 0
    var A = 0
    var B = 0
    var histroyArrayCount = [Int]()
    var input2 = [Int]()
    var gameTimer : Timer?
    var date : String?
    var gameResult = ""
    var apiRequest = APIRequest()
    var histroyArray:[[String]] = []
    var num = [0,1,2,3,4,5,6,7,8,9]
    var ans = [0,1,2,3]
    var ansString : String?
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var numbutton1: UIButton!
    @IBOutlet weak var numbutton2: UIButton!
    @IBOutlet weak var numbutton3: UIButton!
    @IBOutlet weak var numbutton4: UIButton!
    @IBOutlet weak var numbutton5: UIButton!
    @IBOutlet weak var numbutton6: UIButton!
    @IBOutlet weak var numbutton7: UIButton!
    @IBOutlet weak var numbutton8: UIButton!
    @IBOutlet weak var numbutton9: UIButton!
    @IBOutlet weak var numbutton0: UIButton!
    @IBOutlet weak var buttonc: UIButton!
    @IBOutlet weak var buttongo: UIButton!
    @IBOutlet weak var buttonagain: UIButton!
    
    @IBAction func numbutton1(_ sender: Any) {
        checkBtn(input2Int: 1, inputString: "1")
        numbutton1.isEnabled = false
    }
    @IBAction func numbutton2(_ sender: Any) {
        checkBtn(input2Int: 2, inputString: "2")
        numbutton2.isEnabled = false
    }
    @IBAction func numbutton3(_ sender: Any) {
        checkBtn(input2Int: 3, inputString: "3")
        numbutton3.isEnabled = false
    }
    @IBAction func numbutton4(_ sender: Any) {
        checkBtn(input2Int: 4, inputString: "4")
        numbutton4.isEnabled = false
    }
    @IBAction func numbutton5(_ sender: Any) {
        checkBtn(input2Int: 5, inputString: "5")
        numbutton5.isEnabled = false
    }
    @IBAction func numbutton6(_ sender: Any) {
        checkBtn(input2Int: 6, inputString: "6")
        numbutton6.isEnabled = false
    }
    @IBAction func numbutton7(_ sender: Any) {
        checkBtn(input2Int: 7, inputString: "7")
        numbutton7.isEnabled = false
    }
    @IBAction func numbutton8(_ sender: Any) {
        checkBtn(input2Int: 8, inputString: "8")
        numbutton8.isEnabled = false
    }
    @IBAction func numbutton9(_ sender: Any) {
        checkBtn(input2Int: 9, inputString: "9")
        numbutton9.isEnabled = false
    }
    @IBAction func numbutton0(_ sender: Any) {
        checkBtn(input2Int: 0, inputString: "0")
        numbutton0.isEnabled = false
    }
    
    //清除鍵Ｃ
    @IBAction func numbuttonc(_ sender: Any) {
        self.btnSwitch(aa: true, bb: false , cc: true)
        count = 0
        input2 = []
        input.text?.removeAll()}
    
    //送出鍵Enter
    @IBAction func Buttongo(_ sender: Any) {
        btnSwitch(aa: true, bb: false , cc:true)
        codeAB()}
    
    //重新開始鍵
    @IBAction func buttonagain(_ sender: Any) {
        self.gameResult = "重新"
        self.gameTimer?.fireDate = NSDate.distantFuture
        let again = UIAlertController(title: "提示", message: "請問要重新開始嗎?" , preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel){ (UIAlertAction) in
            self.gameTimer?.fireDate = NSDate.init() as Date}
        let ok = UIAlertAction(title: "確認", style: .default) { (UIAlertAction) in
            if self.buttonc.isEnabled == true{
                self.historyDatafunc()
            }
            self.gameTimer?.invalidate()
            self.labelAppend()}
        again.addAction(cancel)
        again.addAction(ok)
        self.present(again, animated: true, completion: nil)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelAppend()
    }
}
