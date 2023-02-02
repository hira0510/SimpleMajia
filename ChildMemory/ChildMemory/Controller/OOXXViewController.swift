import UIKit
enum status {
    case win
    case lose
    case tie
}
class OOXXViewController: UIViewController {
    @IBOutlet var views: OOXXView!
    let viewModel = OOXXViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.btnArray = [views.btn1, views.btn2, views.btn3, views.btn4, views.btn5, views.btn6, views.btn7, views.btn8, views.btn9]
        resetData()
    }
    func timerSet() {
        var t = 0
        viewModel.gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            t = t + 1
            self.views.time.text = String(format: "%02d:%02d", t / 60, t % 60)
        })
    }
    @IBAction func dismissBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func reset(_ sender: Any) {
        viewModel.gameTimer?.fireDate = NSDate.distantFuture
        let again = UIAlertController(title: "提示", message: "請問要重新開始嗎?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            self.viewModel.gameTimer?.fireDate = NSDate.init() as Date
        }
        let ok = UIAlertAction(title: "確認", style: .default) { (UIAlertAction) in
            self.viewModel.gameTimer?.invalidate()
            self.viewModel.oArrayRecord.append(self.viewModel.oArray)
            self.viewModel.xArrayRecord.append(self.viewModel.xArray)
            UserDefaults.standard.set(self.viewModel.xArrayRecord, forKey: "xArray")
            UserDefaults.standard.set(self.viewModel.oArrayRecord, forKey: "oArray")
            self.viewModel.time.append("\(self.views.time.text ?? "")")
            UserDefaults.standard.set(self.viewModel.time, forKey: "time")
            self.viewModel.text.append("重新")
            UserDefaults.standard.set(self.viewModel.text, forKey: "text")
            self.resetData()
        }
        again.addAction(cancel)
        again.addAction(ok)
        self.present(again, animated: true, completion: nil)
    }
    @IBAction func didClick(_ sender: UIButton) {
        if sender.image(for: .normal) == nil && viewModel.whoClick == true {
            sender.setImage(UIImage(named: viewModel.mine), for: .normal)
            sender.isUserInteractionEnabled = false
            viewModel.oArray.append(sender.tag)
            if viewModel.oArray.count + viewModel.xArray.count != 9 && views.chooseMode.selectedSegmentIndex == 1 {
                viewModel.whoClick = false
            }
        } else if sender.image(for: .normal) == nil && viewModel.whoClick == false {
            sender.setImage(UIImage(named: viewModel.other), for: .normal)
            sender.isUserInteractionEnabled = false
            viewModel.xArray.append(sender.tag)
            viewModel.whoClick = true
        }
        if viewModel.oArray.contains(1) && viewModel.oArray.contains(4) && viewModel.oArray.contains(7) || viewModel.oArray.contains(2) && viewModel.oArray.contains(5) && viewModel.oArray.contains(8) || viewModel.oArray.contains(3) && viewModel.oArray.contains(6) && viewModel.oArray.contains(9) || viewModel.oArray.contains(1) && viewModel.oArray.contains(5) && viewModel.oArray.contains(9) || viewModel.oArray.contains(3) && viewModel.oArray.contains(5) && viewModel.oArray.contains(7) || viewModel.oArray.contains(1) && viewModel.oArray.contains(2) && viewModel.oArray.contains(3) || viewModel.oArray.contains(4) && viewModel.oArray.contains(5) && viewModel.oArray.contains(6) || viewModel.oArray.contains(7) && viewModel.oArray.contains(8) && viewModel.oArray.contains(9) {
            toast(status: .win)
        } else if viewModel.xArray.contains(1) && viewModel.xArray.contains(4) && viewModel.xArray.contains(7) || viewModel.xArray.contains(2) && viewModel.xArray.contains(5) && viewModel.xArray.contains(8) || viewModel.xArray.contains(3) && viewModel.xArray.contains(6) && viewModel.xArray.contains(9) || viewModel.xArray.contains(1) && viewModel.xArray.contains(5) && viewModel.xArray.contains(9) || viewModel.xArray.contains(3) && viewModel.xArray.contains(5) && viewModel.xArray.contains(7) || viewModel.xArray.contains(1) && viewModel.xArray.contains(2) && viewModel.xArray.contains(3) || viewModel.xArray.contains(4) && viewModel.xArray.contains(5) && viewModel.xArray.contains(6) || viewModel.xArray.contains(7) && viewModel.xArray.contains(8) && viewModel.xArray.contains(9) {
            toast(status: .lose)
        } else if viewModel.oArray.count + viewModel.xArray.count == 9 {
            toast(status: .tie)
        } else if viewModel.oArray.count + viewModel.xArray.count != 9 && views.chooseMode.selectedSegmentIndex == 0 {
            self.random(btn: sender)
        }
    }
    func random(btn: UIButton) {
        var num = Int.random(in: 1...9)
        while viewModel.xArray.contains(num) || viewModel.oArray.contains(num) {
            num = Int.random(in: 1...9)
        }
        viewModel.xArray.append(num)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewModel.btnArray[num - 1].setImage(UIImage(named: self.viewModel.other), for: .normal)
            self.viewModel.btnArray[num - 1].isUserInteractionEnabled = false
            if self.viewModel.xArray.contains(1) && self.viewModel.xArray.contains(4) && self.viewModel.xArray.contains(7) || self.viewModel.xArray.contains(2) && self.viewModel.xArray.contains(5) && self.viewModel.xArray.contains(8) || self.viewModel.xArray.contains(3) && self.viewModel.xArray.contains(6) && self.viewModel.xArray.contains(9) || self.viewModel.xArray.contains(1) && self.viewModel.xArray.contains(5) && self.viewModel.xArray.contains(9) || self.viewModel.xArray.contains(3) && self.viewModel.xArray.contains(5) && self.viewModel.xArray.contains(7) || self.viewModel.xArray.contains(1) && self.viewModel.xArray.contains(2) && self.viewModel.xArray.contains(3) || self.viewModel.xArray.contains(4) && self.viewModel.xArray.contains(5) && self.viewModel.xArray.contains(6) || self.viewModel.xArray.contains(7) && self.viewModel.xArray.contains(8) && self.viewModel.xArray.contains(9) {
                self.toast(status: .lose)
            }
        }
    }
    func toast (status: status) {
        viewModel.gameTimer?.invalidate()
        let alertController: UIAlertController
        viewModel.time.append("\(views.time.text ?? "")")
        viewModel.oArrayRecord.append(viewModel.oArray)
        viewModel.xArrayRecord.append(viewModel.xArray)
        switch status {
        case .win:
            if views.chooseMode.selectedSegmentIndex == 0 {
                alertController = UIAlertController(title: "恭喜您贏了！", message: "請問要重新開始嗎?", preferredStyle: .alert)
                viewModel.text.append("您贏了")
            } else {
                alertController = UIAlertController(title: "恭喜玩家Ａ贏了！", message: "請問要重新開始嗎?", preferredStyle: .alert)
                viewModel.text.append("玩家Ａ贏了")
            }
        case .lose:
            if views.chooseMode.selectedSegmentIndex == 0 {
                alertController = UIAlertController(title: "您輸了...", message: "請問要重新開始嗎?", preferredStyle: .alert)
                viewModel.text.append("您輸了")
            } else {
                alertController = UIAlertController(title: "恭喜玩家Ｂ贏了！", message: "請問要重新開始嗎?", preferredStyle: .alert)
                viewModel.text.append("玩家Ｂ贏了")
            }
        default:
            alertController = UIAlertController(title: "平手！！", message: "請問要重新開始嗎?", preferredStyle: .alert)
            viewModel.text.append("平手")
        }
        UserDefaults.standard.set(viewModel.time, forKey: "time")
        UserDefaults.standard.set(viewModel.text, forKey: "text")
        UserDefaults.standard.set(viewModel.xArrayRecord, forKey: "xArray")
        UserDefaults.standard.set(viewModel.oArrayRecord, forKey: "oArray")
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            for i in 0..<self.viewModel.btnArray.count {
                self.viewModel.btnArray[i].isUserInteractionEnabled = false
            }
        }
        let ok = UIAlertAction(title: "重新開始", style: .default) { (UIAlertAction) in
            self.resetData()
        }
        alertController.addAction(cancel)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    func resetData() {
        timerSet()
        if views.chooseOX.selectedSegmentIndex == 0 {
            viewModel.mine = "O"
            viewModel.other = "X"
        } else {
            viewModel.mine = "X"
            viewModel.other = "O"
        }
        viewModel.oArray = []
        viewModel.xArray = []
        viewModel.whoClick = true
        for i in 0..<viewModel.btnArray.count {
            viewModel.btnArray[i].setImage(nil, for: .normal)
            viewModel.btnArray[i].isUserInteractionEnabled = true
        }
    }
}
