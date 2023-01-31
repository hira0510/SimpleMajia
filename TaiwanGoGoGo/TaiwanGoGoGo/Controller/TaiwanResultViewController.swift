//
//  TaiwanResultViewController.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/28.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class TaiwanResultViewController: UIViewController {

    @IBOutlet var views: TaiwanResultView!
    
    var taiwanSequence: Info?
    
    private var favoritesData: [Info] = {
        return UserDefaults.standard.object(forKey: "FavoriteData") as? [Info] ?? []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc
    func previousBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func didClickAddressBtn() {
        guard let model = taiwanSequence else { return }
        let view = TaiwanMapView(frame: UIScreen.main.bounds, px: model.px, py: model.py)
        self.view.addSubview(view)
    }
    
    func setupUI() {
        views.dismissButton.addTarget(self, action: #selector(previousBack), for: .touchUpInside)
        guard let model = taiwanSequence else { return }
        views.addressButton.addTarget(self, action: #selector(didClickAddressBtn), for: .touchUpInside)
        views.addressLabel.attributedText = mapTitle(address: model.address)
        views.titleLabel.text = "地點：" + model.name
        views.telLabel.text = "電話：" + model.tel
        views.timeLabel.text = "營業時間：" + model.openTime
        views.moneyLabel.text = "票價：" + model.ticketInfo
        views.introdutionLabel.text = "介紹：" + model.toldeScribe
        if model.picture == "" {
            views.mImageView.image = UIImage(named: "noImage")
        } else {
            if let url = URL(string: model.picture) {
                DispatchQueue.main.async {
                    UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "noImage"), options: nil, progressBlock: nil) { (result) in
                        switch result {
                        case .success(let success):
                            self.views.mImageView.image = success.image
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
    }
    
    func mapTitle(address: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "地址：\(address)", attributes: [
          .font: UIFont(name: "PingFangTC-Medium", size: 16.0)!,
          .foregroundColor: UIColor.blue,
          .kern: -0.41
        ])
        attributedString.addAttributes([
          .font: UIFont(name: "PingFangTC-Medium", size: 16.0)!,
          .foregroundColor: UIColor.black,
          .kern: -0.33
        ], range: NSRange(location: 0, length: 3))
        return attributedString
    }
}
