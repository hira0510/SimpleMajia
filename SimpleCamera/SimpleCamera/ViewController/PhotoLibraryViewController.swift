//
//  PhotoLibraryViewController.swift
//  camera
//
//  Created by Hira on 2020/1/17.
//

import UIKit

class PhotoLibraryViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        ImageView.image = image
    }
    
    @IBAction func backBtnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
