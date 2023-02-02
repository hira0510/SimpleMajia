//
//  SameThirdViewController.swift
//  SameCard
//
//  Created by  on 2020/3/27.
//

import UIKit

class SameThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mTableView: UITableView!

    var time: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(ScoreTableViewCell.nib, forCellReuseIdentifier: "ScoreTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        time = UserDefaults.standard.array(forKey: "time") as? [String] ?? []
        mTableView.reloadData()
    }

    @IBAction func dismissClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
        cell.configCell(score: 0, time: time[indexPath.row])
        return cell
    }
}
