//
//  MainCode.swift
//  GameAB2
//
//  Created by 王一平 on 2019/7/24.
//  Copyright © 2019 王一平. All rights reserved.
//

import UIKit

extension PlayViewController {

    func ABShuffle() {
        num.shuffle()
        ans [0...3] = num [0...3]
        print(ans)
    }

    //送出enter鍵
    func checkBtn(input2Int: Int, inputString: String) {
        input2 += [input2Int]
        input.text?.append("\(inputString)")
        count += 1
        close() }

    //button狀態
    func btnSwitch(aa: Bool, bb: Bool, cc: Bool) {
        numbutton1.isEnabled = aa
        numbutton2.isEnabled = aa
        numbutton3.isEnabled = aa
        numbutton4.isEnabled = aa
        numbutton5.isEnabled = aa
        numbutton6.isEnabled = aa
        numbutton7.isEnabled = aa
        numbutton8.isEnabled = aa
        numbutton9.isEnabled = aa
        numbutton0.isEnabled = aa
        buttongo.isEnabled = bb
        buttonc.isEnabled = cc
    }

    //重新開始清除資料
    func clearInt() {
        count = 0
        A = 0
        B = 0
        times = 0
        input2 = []
        self.input.text?.removeAll()
        self.label1.text?.removeAll()
        self.label2.text?.removeAll()
        self.time.text = "00:00"
    }

    //輸入4個數字後button狀態改變
    func close() {
        if count >= 4 {
            btnSwitch(aa: false, bb: true, cc: true)
        }
    }

    //贏了的提示視窗＆時間停止＆儲存資料
    func win () {
        gameTimer?.invalidate()
        historyDatafunc()
        let win = UIAlertController(title: "恭喜您答對了！", message: "請問要重新開始嗎?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            self.btnSwitch(aa: false, bb: false, cc: false) }
        let ok = UIAlertAction(title: "重新開始", style: .default) { (UIAlertAction) in
            self.labelAppend() }
        win.addAction(cancel)
        win.addAction(ok)
        self.present(win, animated: true, completion: nil)
    }

    //輸了的提示視窗＆時間停止＆儲存資料
    func lose () {
        gameTimer?.invalidate()
        historyDatafunc()
        let lose = UIAlertController(title: "遊戲失敗....", message: "正確答案是：\(ans[0])\(ans[1])\(ans[2])\(ans[3])，\n請問要重新開始嗎?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            self.btnSwitch(aa: false, bb: false, cc: false) }
        let ok = UIAlertAction(title: "重新開始", style: .default) { (UIAlertAction) in
            self.labelAppend() }
        lose.addAction(cancel)
        lose.addAction(ok)
        self.present(lose, animated: true, completion: nil)
    }

    //主要判斷幾Ａ幾Ｂ和有無超過次數的方法
    func codeAB() {
        times += 1
        input.text?.removeAll()
        for i in 0...3 {
            for j in 0...3 {
                if ans[i] == input2 [j] {
                    if i == j {
                        A += 1
                    } else if i != j {
                        B += 1
                    }
                }
            }
        }
        if A == 4 /*&& B == 0 */ {
            self.gameResult = "成功"
            labelAppendAB()
            win()
        } else if times == 15 {
            self.gameResult = "失敗"
            labelAppendAB()
            lose()
        } else {
            labelAppendAB()
            count = 0
            A = 0
            B = 0
            input2 = []
            input.text?.removeAll()
        }
    }

    //一開始的lable提示
    func labelAppend() {
        ABShuffle()
        apiRequest.urlRequest()
        self.btnSwitch(aa: true, bb: false, cc: true)
        self.clearInt()
        var t = 0
        self.histroyArrayCount += [1]
        DispatchQueue.main.asyncAfter (deadline: .now() + 0.8) {
            self.label1.text?.append("本局總共有\n")
            self.label2.text?.append("15次機會\n")
            self.gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
                t = t + 1
                self.time.text = String(format: "%02d:%02d", t / 60, t % 60)
                let formatter = DateFormatter()
                let now = Date()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                self.date = formatter.string(from: now)
            })
        }
    }

    //輸入完畢的結果
    func labelAppendAB() {
        label1.text?.append("第\(times)次   \(input2[0])\(input2[1])\(input2[2])\(input2[3]) \n")
        label2.text?.append("得\(A)A\(B)B\n")
    }

    //歷史紀錄的資料儲存
    func historyDatafunc() {
        histroyArray.insert((["\(ans[0])\(ans[1])\(ans[2])\(ans[3])", "15", "\(self.time.text!)", "\(date!)", "\(String(times))", "\(gameResult)", "\(self.histroyArrayCount)"]), at: 0)
        let model = HistoryData(answer: "\(ans[0])\(ans[1])\(ans[2])\(ans[3])", retrytimes: "15", timer: self.time.text!, date: date!, times: String(times), gameresult: gameResult, histroyArrayCount: self.histroyArrayCount, histroyArray: histroyArray)
        model.aa()
        var modeldata: Data
        if #available(iOS 11.0, *) {
            modeldata = try! NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false)
        } else {
            modeldata = NSKeyedArchiver.archivedData(withRootObject: model)
        }
        UserDefaults.standard.set(modeldata, forKey: "myModel")
        print(histroyArray)
        print(model)
    }
}
