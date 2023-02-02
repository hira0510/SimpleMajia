//
//  SameFirstViewController.swift
//  SameCard
//
//  Created by  on 2020/3/3.
//

import UIKit
import AVFoundation
import MediaPlayer

class SameFirstViewController: UIViewController {

    var player: AVQueuePlayer = AVQueuePlayer()
    var playerItem: AVPlayerItem?
    var playerLoop: AVPlayerLooper?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if player.status == .unknown {
            playTheBgSong()
        } else {
            player.play()
        }
    }

    @IBAction func didClickDismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.player.pause()
    }

    @IBAction func gogoClick(_ sender: UIButton) {
        var vc = UIViewController()
        if sender.tag == 0 {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SameSecendViewController") as! SameSecendViewController
            player.pause()
        } else {
            vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SameThirdViewController") as! SameThirdViewController
        }
        self.present(vc, animated: true, completion: nil)
    }

    func playTheBgSong() {
        if let url = Bundle.main.url(forResource: "Ellinia2", withExtension: "mp3") {
            playerItem = AVPlayerItem(url: url)
            playerLoop = AVPlayerLooper(player: player, templateItem: AVPlayerItem(url: url))
            player.play()
        }
    }
}

