import UIKit
class ToastViewController: UIViewController {
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    var oArray: [Int] = []
    var xArray: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        btnO()
        btnX()
    }
    @IBAction func dismissBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func btnO() {
        for i in 0..<oArray.count {
            switch oArray[i] {
            case 1:
                btn1.setImage(UIImage(named: "O"), for: .normal)
            case 2:
                btn2.setImage(UIImage(named: "O"), for: .normal)
            case 3:
                btn3.setImage(UIImage(named: "O"), for: .normal)
            case 4:
                btn4.setImage(UIImage(named: "O"), for: .normal)
            case 5:
                btn5.setImage(UIImage(named: "O"), for: .normal)
            case 6:
                btn6.setImage(UIImage(named: "O"), for: .normal)
            case 7:
                btn7.setImage(UIImage(named: "O"), for: .normal)
            case 8:
                btn8.setImage(UIImage(named: "O"), for: .normal)
            case 9:
                btn9.setImage(UIImage(named: "O"), for: .normal)
            default: break
            }
        }
    }
    func btnX() {
        for i in 0..<xArray.count {
            switch xArray[i] {
            case 1:
                btn1.setImage(UIImage(named: "X"), for: .normal)
            case 2:
                btn2.setImage(UIImage(named: "X"), for: .normal)
            case 3:
                btn3.setImage(UIImage(named: "X"), for: .normal)
            case 4:
                btn4.setImage(UIImage(named: "X"), for: .normal)
            case 5:
                btn5.setImage(UIImage(named: "X"), for: .normal)
            case 6:
                btn6.setImage(UIImage(named: "X"), for: .normal)
            case 7:
                btn7.setImage(UIImage(named: "X"), for: .normal)
            case 8:
                btn8.setImage(UIImage(named: "X"), for: .normal)
            case 9:
                btn9.setImage(UIImage(named: "X"), for: .normal)
            default: break
            }
        }
    }
}
