//
//  HistoryTableViewController.swift
//  GameAB2
//
//  Created by 王一平 on 2019/7/31.
//  Copyright © 2019 王一平. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    var myModelData: Data?
    var myModel: HistoryData?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.history()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.myModel != nil {
            return self.myModel!.histroyArrayCount.count
        } else {
            print("尚未有紀錄")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "歷史紀錄"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.configCellWithHistroy(num_: indexPath.row + 1, answer_: self.myModel!.histroyArray[(indexPath.row)][0], retryTime_: self.myModel!.histroyArray[indexPath.row][1], timer_: self.myModel!.histroyArray[indexPath.row][2], date_: self.myModel!.histroyArray[indexPath.row][3], times_: self.myModel!.histroyArray[indexPath.row][4])

        if self.myModel!.histroyArray[(indexPath.row)][5] == "失敗" {
            cell.configCellWithResult(coler: UIColor.red, gameresult_: self.myModel!.histroyArray[indexPath.row][5])
        } else if self.myModel!.histroyArray[(indexPath.row)][5] == "成功" {
            cell.configCellWithResult(coler: UIColor.green, gameresult_: self.myModel!.histroyArray[indexPath.row][5])
        } else if self.myModel!.histroyArray[(indexPath.row)][5] == "重新" {
            cell.configCellWithResult(coler: UIColor.orange, gameresult_: self.myModel!.histroyArray[indexPath.row][5])
        }
        return cell
    }
    
    //歷史資料解碼讀取
    func history() {
        if let mdata = UserDefaults.standard.data(forKey: "myModel") {
            self.myModelData = mdata
            self.myModel = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(myModelData!) as! HistoryData
            self.tableView.reloadData()
        } else {
            print("尚未有紀錄")
        }
    }
}
