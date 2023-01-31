//
//  PhoneWallpaperImageViewController.swift
//  PhoneWallpaper
//
//  Created by Hira on 2021/3/31.
//

import UIKit
import Photos

class PhoneWallpaperImageViewController: UIViewController {

    var imageModel: Data!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBAction func didClickBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickFavor(_ sender: Any) {
        
        guard var favorData = UserDefaults.standard.object(forKey: "favor") as? [Data] else {
            favoriteBtn.setImage(UIImage(named: "PhoneWallpaper_choose"), for: .normal)
            UserDefaults.standard.setValue([imageModel], forKey: "favor")
            return
        }
        if favorData.contains(imageModel) {
            for (i, value) in favorData.enumerated() {
                if value == imageModel {
                    favoriteBtn.setImage(UIImage(named: "PhoneWallpaper_no"), for: .normal)
                    favorData.remove(at: i)
                    break
                }
            }
        } else {
            favoriteBtn.setImage(UIImage(named: "PhoneWallpaper_choose"), for: .normal)
            favorData.append(imageModel)
        }
        UserDefaults.standard.set(favorData, forKey: "favor")
    }
    
    @IBAction func save(sender: UIButton) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized:
            // 已授權
            UIImageWriteToSavedPhotosAlbum(capture(), nil, nil, nil)
            let view = ShowToastView(frame: UIScreen.main.bounds)
            self.view.addSubview(view)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async(execute: {
                    guard status == .authorized else { return }
                    self.save(sender: sender)
                })
            })
        default:
            DispatchQueue.main.async(execute: { () -> Void in
                let alertController = UIAlertController(title: "前往设置开启相片权限", message: "您还没有开启相册权限，开启后才能保存图片", preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: "确认", style: .default, handler: {
                    (action) -> Void in
                    let url = URL(string: UIApplication.openSettingsURLString)
                    if let url = url, UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in })
                    }
                })

                alertController.addAction(settingsAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setXib()
    }
    
    func setXib() {
        favoriteBtn.layer.cornerRadius = favoriteBtn.frame.height / 2
        downloadButton.layer.cornerRadius = downloadButton.frame.height / 2
        backButton.layer.cornerRadius = backButton.frame.height / 2
        
        guard let data = imageModel else {
            self.mImageView.image = UIImage(named: "bg")
            self.mImageView.alpha = 0.3
            return
        }
        self.mImageView.alpha = 1
        self.mImageView.image = UIImage(data: data)
        
        guard let favorData = UserDefaults.standard.object(forKey: "favor") as? [Data] else { return }
 
        if favorData.contains(imageModel) {
            favoriteBtn.setImage(UIImage(named: "PhoneWallpaper_choose"), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(named: "PhoneWallpaper_no"), for: .normal)
        }
    }
    
    func capture() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.mImageView.frame.size, self.mImageView.isOpaque, UIScreen.main.scale)
        self.mImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
