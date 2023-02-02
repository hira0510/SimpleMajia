//
//  ScoreViewController.swift
//  WhacAMole
//
//  Created by Hira on 2020/2/25.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var score: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.register(ScoreTableViewCell.nib, forCellReuseIdentifier: "ScoreTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        score = UserDefaults.standard.array(forKey: "score") as? [Int] ?? []
        mTableView.reloadData()
    }

    @IBAction func dismissClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return score.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
        cell.configCell(score: score[indexPath.row])
        return cell
    }
}
