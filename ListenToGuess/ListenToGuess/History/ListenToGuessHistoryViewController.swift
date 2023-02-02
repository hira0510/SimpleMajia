//
//  ListenToGuessHistoryViewController.swift
//  ListenToGuess
//
//  Created by  on 2021/11/26.
//

import UIKit

class ListenToGuessHistoryViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    let time = UserDefaults.standard.stringArray(forKey: "ListenToGuessModelTime") ?? []
    let score = UserDefaults.standard.stringArray(forKey: "ListenToGuessModelScore") ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension ListenToGuessHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let times = time[indexPath.item]
        let scores = score[indexPath.item]
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "star")
            content.text = scores
            content.secondaryText = times
            cell.contentConfiguration = content
            return cell
        } else {
            cell.textLabel?.text = scores
            cell.detailTextLabel?.text = times
            return cell
        }
    }
}
