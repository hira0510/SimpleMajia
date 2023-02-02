//
//  MenuViewController.swift
//  PictureEdit
//
//  Created by Hira on 2020/2/11.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //相簿選取照片
    var libraryImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func photoLibrary(_ sender: Any) {
        //self.performSegue(withIdentifier: "showPhotoLibrary", sender: self)
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        imagePickerVC.modalPresentationStyle = .popover
        let popover = imagePickerVC.popoverPresentationController
        popover?.sourceView = sender as? UIView
        popover?.sourceRect = (sender as AnyObject).bounds
        popover?.permittedArrowDirections = .any

        show(imagePickerVC, sender: self)
    }
    @IBAction func openDrawBtn(_ sender: UIButton) {
        let view = ShowToastView(frame: UIScreen.main.bounds, type: 0)
        view.insideView.isHidden = true
        view.didClickDismissBtnHandler = {
            self.present(view.vc!, animated: true, completion: nil)
        }
        self.view.addSubview(view)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as? UIImage
        self.libraryImage = image
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "showPhotoLibrary", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showPhotoLibrary" {
            let photoLibraryController = segue.destination as! PhotoDrawAndSaveViewController
            photoLibraryController.image = libraryImage
        }
    }
}

