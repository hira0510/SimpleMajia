//
//  PhoneWallpaperMainViewController.swift
//  PhoneWallpaper
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class PhoneWallpaperMainViewController: UIViewController {

    private var imageModel: [Data] = []

    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(PhoneWallpaperCollectionViewCell.nib, forCellWithReuseIdentifier: "PhoneWallpaperCollectionViewCell")
        mCollectionView.register(PhoneWallpaperFooterCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PhoneWallpaperFooterCell")
        request()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

    func request() {
        DispatchQueue.main.async {
            for i in 0..<10 {//https://api.mz-moe.cn/img.php
                //https://acg.toubiec.cn/random.php
                if let url = URL(string: "https://api.mz-moe.cn/img.php") {
                    if let data = try? Data(contentsOf: url) {
                        self.imageModel.append(data)
                    } else {
                        self.imageModel.append(Data())
                    }
                } else {
                    self.imageModel.append(Data())
                }
                if i == 9 {
                    self.mCollectionView.scrollToItem(at: IndexPath.init(), at: .top, animated: true)
                    self.mCollectionView.reloadData()
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                }
            }
        }
    }
}

extension PhoneWallpaperMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneWallpaperCollectionViewCell", for: indexPath) as! PhoneWallpaperCollectionViewCell
        guard imageModel.count > indexPath.item else {
            cell.config(img: nil)
            return cell
        }
        cell.config(img: imageModel[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "PhoneWallpaper", bundle: nil).instantiateViewController(withIdentifier: "PhoneWallpaperImageViewController") as! PhoneWallpaperImageViewController
        vc.imageModel = imageModel[indexPath.item]
        self.present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenFull = UIScreen.main.bounds.size
        return CGSize(width: screenFull.width / 2, height: 300 / 375 * screenFull.width)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PhoneWallpaperFooterCell", for: indexPath) as! PhoneWallpaperFooterCell
            footer.didClickChangeBtn = { [weak self] in
                guard let `self` = self else { return }
                self.imageModel = []
                self.activityIndicatorView.startAnimating()
                self.activityIndicatorView.isHidden = false
                self.request()
            }
            return footer
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 40)
    }
}
