//
//  PhoneWallpaperFavorViewController.swift
//  PhoneWallpaper
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class PhoneWallpaperFavorViewController: UIViewController {

    @IBOutlet weak var mCollectionView: UICollectionView!

    var favorImgModel: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(PhoneWallpaperCollectionViewCell.nib, forCellWithReuseIdentifier: "PhoneWallpaperCollectionViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        setData()
    }

    func setData() {
        favorImgModel = []
        guard let favorData = UserDefaults.standard.object(forKey: "favor") as? [Data] else { return }
        for value in favorData {
            favorImgModel.append(value)
        }
        mCollectionView.reloadData()
    }
}

extension PhoneWallpaperFavorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorImgModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneWallpaperCollectionViewCell", for: indexPath) as! PhoneWallpaperCollectionViewCell
        cell.config(img: favorImgModel[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "PhoneWallpaper", bundle: nil).instantiateViewController(withIdentifier: "PhoneWallpaperImageViewController") as! PhoneWallpaperImageViewController
        vc.imageModel = favorImgModel[indexPath.item]
        self.present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenFull = UIScreen.main.bounds.size
        return CGSize(width: screenFull.width / 2, height: 300 / 375 * screenFull.width)
    }
}
