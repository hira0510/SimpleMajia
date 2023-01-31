//
//  SetItemViewController.swift
//  GymTraining
//
//  Created by Hira on 2020/2/21.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class SetItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mTableView: UITableView!
    var name: [String] = UserDefaults.standard.array(forKey: "name") as? [String] ?? []
    var time: [Int] = UserDefaults.standard.array(forKey: "time") as? [Int] ?? []

    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(SetTableViewCell.nib, forCellReuseIdentifier: "SetTableViewCell")
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addItem(_ sender: UIButton) {
        let view = SetToastView(frame: UIScreen.main.bounds)
        view.nameText.text = ""
        view.timeText.text = ""
        view.fromModify = false
        view.didClickDismissBtnHandler = {
            self.name = UserDefaults.standard.array(forKey: "name") as? [String] ?? []
            self.time = UserDefaults.standard.array(forKey: "time") as? [Int] ?? []
            self.mTableView.reloadData()
        }
        self.view.addSubview(view)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetTableViewCell", for: indexPath) as! SetTableViewCell
        if name != [] {
            cell.configCell(name: name[indexPath.row], time: String(time[indexPath.row]))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = SetToastView(frame: UIScreen.main.bounds)
        view.nameText.text = name[indexPath.row]
        view.timeText.text = String(time[indexPath.row])
        view.num = indexPath.row
        view.fromModify = true
        view.didClickDismissBtnHandler = {
            self.name = UserDefaults.standard.array(forKey: "name") as? [String] ?? []
            self.time = UserDefaults.standard.array(forKey: "time") as? [Int] ?? []
            self.mTableView.reloadData()
        }
        self.view.addSubview(view)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        name.remove(at: indexPath.row)
        time.remove(at: indexPath.row)
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(time, forKey: "time")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
}
