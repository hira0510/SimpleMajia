//
//  ListenToGuessPlayViewController.swift
//  ListenToGuess
//
//  Created by  on 2021/11/25.
//

import UIKit

protocol ListenToGuessPlayVCProtocol: AnyObject {
    func leaveVc()
}

class ListenToGuessPlayViewController: UIViewController {
    
    @IBOutlet var views: ListenToGuessPlayViews!
    
    public weak var delegate: ListenToGuessPlayVCProtocol?
    private let viewModel = ListenToGuessPlayViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.views.animationView.play()
            self.oneGame()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.player?.pause()
        viewModel.player = nil
        delegate?.leaveVc()
    }
     
    private func setupUI() {
        views.lblArray = [views.ans0Label, views.ans1Label, views.ans2Label, views.ans3Label]
        views.btnArray = [views.ans0Btn, views.ans1Btn, views.ans2Btn, views.ans3Btn]
        views.viewArray = [views.ans0View, views.ans1View, views.ans2View, views.ans3View]
        
        views.animationView.frame = views.musicImage.bounds
        views.musicImage.addSubview(views.animationView)
        
        for (i, btn) in views.btnArray.enumerated() {
            btn.tag = i
            btn.addTarget(self, action: #selector(clickAnsBtn), for: .touchUpInside)
        }
        
        viewModel.musicStr.shuffle()
    }
    
    func oneGame() {
        self.views.setViewNotSelect()
        let ans = viewModel.musicStr[viewModel.musicIndex]
        let player = viewModel.playTheBgSong(ans)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            player?.pause()
            if player == self.viewModel.player {
                self.views.animationView.pause()
            }
        }
        
        var tempAns: [String] = viewModel.musicStr.shuffled().prefix(3) + [ans]
        tempAns.shuffle()
        for (i, txt) in tempAns.enumerated() {
            views.lblArray[i].text = txt
            if ans == txt {
                viewModel.trueIndex = i
            }
        }
    }
    
    @objc func clickAnsBtn(sender: UIButton) {
        let text = views.lblArray[sender.tag].text
        let ansText = viewModel.musicStr[viewModel.musicIndex]
        if text == ansText {
            viewModel.trueCount += 1
            views.setViewSelectTrue(index: viewModel.trueIndex)
        } else {
            views.setViewSelectFalse(select: sender.tag, ans: viewModel.trueIndex)
        }
        viewModel.musicIndex += 1
        
        guard (viewModel.musicIndex + 1) <= 10 else {
            self.views.animationView.pause()
            self.viewModel.player?.pause()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let mView = GameOverView(frame: self.view.frame, score: self.viewModel.trueCount * 10)
                mView.clickRemoveBtnHandler = { [weak self] in
                    guard let `self` = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
                mView.clickRestratBtnHandler = { [weak self] in
                    guard let `self` = self else { return }
                    self.views.countLabel.text = "1/10"
                    self.viewModel.musicIndex = 0
                    self.viewModel.trueIndex = 0
                    self.viewModel.trueCount = 0
                    self.viewModel.musicStr.shuffle()
                    self.views.animationView.play()
                    self.oneGame()
                }
                self.view.addSubview(mView)
            }
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.views.countLabel.text = "\(self.viewModel.musicIndex + 1)/10"
            self.viewModel.player?.pause()
            self.oneGame()
        }
    }
}
