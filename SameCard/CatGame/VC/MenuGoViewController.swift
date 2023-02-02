//
//  MenuGoViewController.swift
//  WhacAMole
//
//  Created by  on 2020/2/24.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MenuGoViewController: UIViewController {

    var player: AVQueuePlayer = AVQueuePlayer()
    var playerItem: AVPlayerItem?
    var playerLoop: AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        playTheBgSong()
    }
    
    @IBAction func gogoClick(_ sender: UIButton) {
        var vc = UIViewController()
        if sender.tag == 0
         {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WhackFirstViewController") as! WhackFirstViewController
        } else {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SameFirstViewController") as! SameFirstViewController
        }
        self.player.pause()
        self.present(vc, animated: true, completion: nil)
    }
    
    func playTheBgSong() {
        if let url = Bundle.main.url(forResource: "Title", withExtension: "mp3") {
            playerItem = AVPlayerItem(url: url)
            playerLoop = AVPlayerLooper(player: player, templateItem: AVPlayerItem(url: url))
            player.play()
        }
    }
}

