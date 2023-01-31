//
//  ZooInfoViewController.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooInfoViewController: UIViewController {

    var zooModel: ZooResultData?
    var imgArray: [String] = []

    @IBOutlet var views: ZooInfoViews!
    
    @IBAction func didClickBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickFavor(_ sender: Any) {
        
        guard var favorData = UserDefaults.standard.object(forKey: "favor") as? [String] else {
            views.favoriteBtn.setImage(UIImage(named: "zoo_Favorites_choose"), for: .normal)
            UserDefaults.standard.setValue([zooModel?.a_name_ch ?? ""], forKey: "favor")
            return
        }
        if favorData.contains(zooModel?.a_name_ch ?? "") {
            for (i, value) in favorData.enumerated() {
                if value == zooModel?.a_name_ch ?? "" {
                    views.favoriteBtn.setImage(UIImage(named: "zoo_Favorites"), for: .normal)
                    favorData.remove(at: i)
                    break
                }
            }
        } else {
            views.favoriteBtn.setImage(UIImage(named: "zoo_Favorites_choose"), for: .normal)
            favorData.append(zooModel?.a_name_ch ?? "")
        }
        UserDefaults.standard.set(favorData, forKey: "favor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setXib()
    }
    
    func setXib() {
        views.mCollectionView.delegate = self
        views.mCollectionView.dataSource = self
        views.mCollectionView.register(ZooInfoCollectionViewCell.nib, forCellWithReuseIdentifier: "ZooInfoCollectionViewCell")
        
        let array: [String] = [zooModel?.a_pic01_url ?? "", zooModel?.a_pic02_url ?? "", zooModel?.a_pic03_url ?? "", zooModel?.a_pic04_url ?? ""]
        imgArray = array.filter { $0 != "" }
        views.mCollectionView.reloadData()
        
        guard let zooModel = zooModel else { return }
        views.nameChLabel.text = "名稱：" + zooModel.a_name_ch
        views.nameEnLabel.text = "英文名稱：" + zooModel.a_name_en
        views.phylumLabel.text = "門：" + zooModel.a_phylum
        views.classLabel.text = "綱：" + zooModel.a_class
        views.orderLabel.text = "目：" + zooModel.a_order
        views.familyLabel.text = "科：" + zooModel.a_family
        views.locationLabel.text = "地點：" + zooModel.a_location
        views.behaviorLabel.text = "特性：" + zooModel.a_behavior
        views.featureLabel.text = "名稱：" + zooModel.a_feature
        views.dietLabel.text = "特徵：" + zooModel.a_diet
        
        guard let favorData = UserDefaults.standard.object(forKey: "favor") as? [String] else { return }
 
        if favorData.contains(zooModel.a_name_ch) {
            views.favoriteBtn.setImage(UIImage(named: "zoo_Favorites_choose"), for: .normal)
        } else {
            views.favoriteBtn.setImage(UIImage(named: "zoo_Favorites"), for: .normal)
        }
    }
}

extension ZooInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooInfoCollectionViewCell", for: indexPath) as! ZooInfoCollectionViewCell
        cell.config(img: imgArray[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: views.mCollectionView.frame.width - 15, height: views.mCollectionView.frame.width - 15)
    }
}
