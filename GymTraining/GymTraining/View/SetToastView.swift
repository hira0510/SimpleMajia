//
//  SetToastView.swift
//  GymTraining
//
//  Created by Hira on 2020/2/21.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class SetToastView: UIView, UITextFieldDelegate {

    @IBOutlet var views: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var enterBtn: UIButton!

    var name: [String] = UserDefaults.standard.array(forKey: "name") as? [String] ?? []
    var time: [Int] = UserDefaults.standard.array(forKey: "time") as? [Int] ?? []
    var num: Int = 0
    var fromModify: Bool = false
    var didClickDismissBtnHandler: (() -> Void)? = { }
    
    @IBAction func enter(_ sender: UIButton) {
        if fromModify {
            name[num] = nameText.text ?? ""
            time[num] = Int(timeText?.text ?? "0") ?? 0
        } else {
            name.append(nameText.text ?? "")
            time.append(Int(timeText?.text ?? "0") ?? 0)
        }
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(time, forKey: "time")
        self.removeFromSuperview()
        didClickDismissBtnHandler?()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    private func initView() {
        Bundle.main.loadNibNamed("SetToastView", owner: self, options: nil)
        self.addSubview(views)

        views.translatesAutoresizingMaskIntoConstraints = false
        views.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        views.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        views.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        views.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        insideView.layer.cornerRadius = 10
        timeText.delegate = self
        nameText.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if timeText.text != "" && nameText.text != "" {
            enterBtn.isEnabled = true
        } else {
            enterBtn.isEnabled = false
        }
    }
}
