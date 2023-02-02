//
//  PhotoLibraryViewController.swift
//  camera
//
//  Created by Hira on 2020/1/17.
//

import UIKit

class PhotoDrawAndSaveViewController: UIViewController {

    @IBOutlet var views: PhotoDrawAndSaveView!

    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        views.imgView.image = image
        setupToolbarViewXib()
    }

    @IBAction func backBtnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func save(sender: UIButton) {
        let image = capture()
        if let data = image.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("copy.jpg")
            try? data.write(to: filename)
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let view = ShowToastView(frame: UIScreen.main.bounds, type: 1)
        view.chooseView.isHidden = true
        view.didClickDismissBtnHandler = {
            self.dismiss(animated: true, completion: nil)
        }
        self.view.addSubview(view)
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func capture() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.views.drawAndImgView.frame.size, self.views.drawAndImgView.isOpaque, UIScreen.main.scale)
        self.views.drawAndImgView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    func setupToolbarViewXib() {
        views.drawAndImgView.frame.size = image?.size ?? CGSize(width: 0, height: 0)
        views.setupToolbarViewXib()
        views.toolView.eraserBtn.setImage(UIImage(named: ""), for: .normal)
        views.toolView.eraserBtn.backgroundColor = UIColor.white
    }
}
