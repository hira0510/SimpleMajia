//
//  TaiwanMainViewController.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/27.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import RxSwift

class TaiwanMainViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    private let viewModel = TaiwanViewModel()

    private var bag: DisposeBag! = DisposeBag()

    deinit {
        bag = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewAndRegisterXib()
        resqustTaiwanDataToObject()
    }
    
    private func setupTableViewAndRegisterXib() {
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.tableFooterView = UIView(frame: CGRect.zero)
        mTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mTableView.register(TaiwanMainCell.nib, forCellReuseIdentifier: "TaiwanMainCell")
    }

    private func resqustTaiwanDataToObject() {
        viewModel.requestTaiwanData().subscribe(onNext: { [weak self] (result) in
            guard let `self` = self else { return }
            guard result else { return }
            self.mTableView.reloadData()
        }, onError: { (error) in
            print(error)
        }).disposed(by: bag)
    }

}

// MARK: - UITableViewDelegate
extension TaiwanMainViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taiwanSequence.value.count > 0 ? viewModel.taiwanSequence.value.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaiwanMainCell", for: indexPath) as! TaiwanMainCell
        guard viewModel.taiwanSequence.value.count > 0 else { return cell }
        let model = viewModel.taiwanSequence.value[indexPath.row]
        cell.configCell(image: model.picture, title: model.name, address: model.address)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.taiwanSequence.value.count > 0 else { return }
        let model = viewModel.taiwanSequence.value[indexPath.row]
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaiwanResultViewController") as! TaiwanResultViewController
        vc.taiwanSequence = model
        navigationController?.pushViewController(vc, animated: true)
    }
}
