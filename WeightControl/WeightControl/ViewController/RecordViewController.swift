//
//  RecordViewController.swift
//  WeightControl
//
//  Created by  on 2020/2/26.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mTableView: UITableView!

    var old: [Int] = UserDefaults.standard.array(forKey: "old") as? [Int] ?? []
    var male: [String] = UserDefaults.standard.array(forKey: "male") as? [String] ?? []
    var height: [Int] = UserDefaults.standard.array(forKey: "height") as? [Int] ?? []
    var weight: [Int] = UserDefaults.standard.array(forKey: "weight") as? [Int] ?? []
    var times: [String] = UserDefaults.standard.array(forKey: "times") as? [String] ?? []

    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(RecordsTableViewCell.nib, forCellReuseIdentifier: "RecordsTableViewCell")
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsTableViewCell", for: indexPath) as! RecordsTableViewCell
        let high = String(format: "%.2f", Float(height[indexPath.row]) / 100)
        let num = Float(high)!
        let num2 = num * num
        let BMI: Float = Float(weight[indexPath.row]) / num2
        let BMIString = String(format: "%.2f", BMI)
        let BMIFloat = Float(BMIString)!

        cell.configCell(old: old[indexPath.row], male: male[indexPath.row], height: height[indexPath.row], weight: weight[indexPath.row], times: times[indexPath.row], BMI: BMIFloat)
        return cell
    }
}
