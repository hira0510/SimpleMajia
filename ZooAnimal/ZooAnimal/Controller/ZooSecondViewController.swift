//
//  ZooSecondViewController.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooSecondViewController: UIViewController {

    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var zooFavorModel: [ZooResultData] = []
    var zooFavorImgModel: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(ZooFirstCollectionViewCell.nib, forCellWithReuseIdentifier: "ZooFirstCollectionViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        setData()
    }
    
    func setData() {
        zooFavorModel = []
        zooFavorImgModel = []
        guard let favorData = UserDefaults.standard.object(forKey: "favor") as? [String] else { return }
        for (i, value) in ZooFirstViewController.zooModel.enumerated() {
            if favorData.contains(value.a_name_ch) {
                zooFavorModel.append(value)
                zooFavorImgModel.append(ZooFirstViewController.zooImgModel[i])
            }
        }
        mCollectionView.reloadData()
    }
}

extension ZooSecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zooFavorModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooFirstCollectionViewCell", for: indexPath) as! ZooFirstCollectionViewCell
        cell.config(name: zooFavorModel[indexPath.item].a_name_ch, img: zooFavorImgModel[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Zoo", bundle: nil).instantiateViewController(withIdentifier: "ZooInfoViewController") as! ZooInfoViewController
        vc.zooModel = zooFavorModel[indexPath.item]
        self.present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenFull = UIScreen.main.bounds.size
        return CGSize(width: screenFull.width / 2, height: 230 / 375 * screenFull.width)
    }
}
