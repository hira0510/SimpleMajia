//
//  EnterDataViewController.swift
//  WeightControl
//
//  Created by  on 2020/2/26.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class EnterDataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let viewModel = EnterDataViewModel()
    
    @IBOutlet weak var mPickView: UIPickerView!
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkBtnClick(_ sender: UIButton) {
        let view = ToastDisplayView(frame: UIScreen.main.bounds, BMI: viewModel.addToUserDefaults(), old: viewModel.old3, male: viewModel.male3)
        view.dismissBtnHandler = {
            self.dismiss(animated: true, completion: nil)
        }
        self.view.addSubview(view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mPickView.delegate = self
        viewModel.setPickViewArray()
        mPickView.selectRow(viewModel.old.count / 2, inComponent: 0, animated: false)
        mPickView.selectRow(viewModel.height.count / 2, inComponent: 2, animated: false)
        mPickView.selectRow(viewModel.weight.count / 2, inComponent: 3, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 100
        case 1:
            return 2
        case 2:
            return 151
        default:
            return 150
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(viewModel.old[row])"
        case 1:
            return viewModel.male[row]
        case 2:
            return "\(viewModel.height[row])"
        default:
            return "\(viewModel.weight[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            viewModel.old3 = viewModel.old[row]
        case 1:
            viewModel.male3 = viewModel.male[row]
        case 2:
            viewModel.height3 = viewModel.height[row]
        default:
            viewModel.weight3 = viewModel.weight[row]
        }
    }
}
