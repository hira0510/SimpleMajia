//
//  ZooFirstViewController.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooFirstViewController: UIViewController {

    let zooRequest = ZooRequest()
    static var zooModel: [ZooResultData] = []
    static var zooImgModel: [Data] = []

    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(ZooFirstCollectionViewCell.nib, forCellWithReuseIdentifier: "ZooFirstCollectionViewCell")
        requestZooData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func requestZooData() {
        zooRequest.urlRequest { (zoodata) in
            ZooFirstViewController.zooModel = zoodata
            
            for value in zoodata {
                if let url = URL(string: value.a_pic01_url) {
                    if let data = try? Data(contentsOf: url) {
                        ZooFirstViewController.zooImgModel.append(data)
                    } else {
                        ZooFirstViewController.zooImgModel.append(Data())
                    }
                } else {
                    ZooFirstViewController.zooImgModel.append(Data())
                }
            }

            DispatchQueue.main.async {
                self.mCollectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
            }
        }
    }
}

extension ZooFirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return ZooFirstViewController.zooModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZooFirstCollectionViewCell", for: indexPath) as! ZooFirstCollectionViewCell
        cell.config(name: ZooFirstViewController.zooModel[indexPath.item].a_name_ch, img: ZooFirstViewController.zooImgModel[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Zoo", bundle: nil).instantiateViewController(withIdentifier: "ZooInfoViewController") as! ZooInfoViewController
        vc.zooModel = ZooFirstViewController.zooModel[indexPath.item]
        self.present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenFull = UIScreen.main.bounds.size
        return CGSize(width: screenFull.width / 2, height: 230 / 375 * screenFull.width)
    }
}
