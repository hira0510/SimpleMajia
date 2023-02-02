//
//  ListenToGuessListViewController.swift
//  ListenToGuess
//
//  Created by  on 2021/11/25.
//

import UIKit
import AVFoundation
import MediaPlayer

class ListenToGuessListViewController: UIViewController {
    
    private var player: AVQueuePlayer?
    private var playerLoop: AVPlayerLooper?

    @IBOutlet weak var startBtn: UIButton! {
        didSet {
            startBtn.setImage(UIImage(named: "菇菇0"), for: .normal)
            startBtn.setImage(UIImage(named: "菇菇1"), for: .highlighted)
        }
    }
    @IBAction func toHistoryPage(_ sender: Any) {
        let vc = UIStoryboard(name: "ListenToGuess", bundle: nil).instantiateViewController(withIdentifier: "ListenToGuessHistoryViewController") as! ListenToGuessHistoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toPlayPage(_ sender: Any) {
        player?.pause()
        player = nil
        let vc = UIStoryboard(name: "ListenToGuess", bundle: nil).instantiateViewController(withIdentifier: "ListenToGuessPlayViewController") as! ListenToGuessPlayViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playTheBgSongLoop()
    }
    
    private func playTheBgSongLoop() {
        player = AVQueuePlayer()
        if let url = Bundle.main.url(forResource: "Ludibrium Flying in a Blue Dream", withExtension: "mp3") {
            playerLoop = AVPlayerLooper(player: player!, templateItem: AVPlayerItem(url: url))
            player?.play()
        }
    }
}
extension ListenToGuessListViewController: ListenToGuessPlayVCProtocol {
    func leaveVc() {
        playTheBgSongLoop()
    }
}
