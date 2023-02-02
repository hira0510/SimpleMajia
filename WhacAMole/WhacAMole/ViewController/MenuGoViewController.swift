//
//  MenuGoViewController.swift
//  WhacAMole
//
//  Created by Hira on 2020/2/24.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MenuGoViewController: UIViewController {

    var player: AVQueuePlayer = AVQueuePlayer()
    var playerItem: AVPlayerItem?
    var looper: AVPlayerLooper?

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
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameStartViewController") as! GameStartViewController
            self.player.pause()
        } else {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func playTheBgSong() {
        if let url = Bundle.main.url(forResource: "[MapleStory BGM] Henesys Floral Life", withExtension: "mp3") {
            playerItem = AVPlayerItem(url: url)
            looper = AVPlayerLooper(player: player, templateItem: AVPlayerItem(url: url))
            player.play()
        }
    }
}

