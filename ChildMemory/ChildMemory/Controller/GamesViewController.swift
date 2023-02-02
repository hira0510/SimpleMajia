//
//  GamesViewController.swift
//  ChildMemory
//
//  Created by  on 2021/3/11.
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet var views: GamesViews!
    let viewModel = GamesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        timerSet()
    }

    func setup() {
        viewModel.btnArray = [views.btn0, views.btn1, views.btn2, views.btn3, views.btn4, views.btn5, views.btn6, views.btn7, views.btn8, views.btn9, views.btn10, views.btn11, views.btn12, views.btn13, views.btn14, views.btn15, views.btn16, views.btn17, views.btn18, views.btn19, views.btn20, views.btn21, views.btn22, views.btn23, views.btn24, views.btn25, views.btn26, views.btn27, views.btn28, views.btn29, views.btn30, views.btn31, views.btn32, views.btn33, views.btn34, views.btn35]
        for (i, value) in viewModel.btnArray.enumerated() {
            value.tag = i
            value.addTarget(self, action: #selector(didClickCard(_:)), for: .touchUpInside)
        }
        random()
    }

    func random() {
        viewModel.imageArray = ["Image-0", "Image-1", "Image-2", "Image-3", "Image-4", "Image-5", "Image-6", "Image-7", "Image-8", "Image-9", "Image-10", "Image-11", "Image-12", "Image-13", "Image-14", "Image-15", "Image-16", "Image-17", "Image-18", "Image-19", "Image-20"]
        viewModel.imageArray.shuffle()
        viewModel.imageArray.remove(at: 0)
        viewModel.imageArray.remove(at: 0)
        viewModel.imageArray.remove(at: 0)
        viewModel.imageArray += viewModel.imageArray
        viewModel.imageArray.shuffle()
    }

    func timerSet() {
        var t = 0
        viewModel.gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            t = t + 1
            self.views.time.text = String(format: "%02d:%02d", t / 60, t % 60)
        })
    }

    @objc func didClickCard(_ sender: UIButton) {
        guard !viewModel.lag else { return }
        sender.setImage(UIImage(named: viewModel.imageArray[sender.tag]), for: .normal)
        sender.isUserInteractionEnabled = false
        guard viewModel.isOpen else { //如果沒有牌是翻開的->就翻開
            viewModel.isOpen = true
            viewModel.pNum = sender.tag
            return
        }

        //如果有牌是翻開的

        if viewModel.btnArray[viewModel.pNum].image(for: .normal) == sender.image(for: .normal) && viewModel.pNum != sender.tag {
            //如果上次翻的牌等於現在翻的牌&&牌面上的那張牌不等於現在翻的牌->達對
            viewModel.isOpen = false
            var count = 0
            views.kawaiImage.image = UIImage(named: "good")
            views.kawaiImage.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.views.kawaiImage.alpha = 1
            }, completion: { _ in
                self.views.kawaiImage.isHidden = true
                self.views.kawaiImage.alpha = 0
            })

            viewModel.btnArray.forEach { (btn) in
                if btn.image(for: .normal) != nil {
                    count += 1
                    if count == 36 {
                        self.viewModel.gameTimer?.invalidate()
                        self.viewModel.gameTimer = nil
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            //加圖
                            self.views.kawaiImage.image = UIImage(named: "good2")
                            self.views.kawaiImage.isHidden = false
                            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                                self.views.kawaiImage.alpha = 1
                            }, completion: { _ in })
                        }
                    }
                }
            }
        } else {
            //->答錯
            viewModel.lag = true
            viewModel.isOpen = false
            self.viewModel.btnArray[self.viewModel.pNum].isUserInteractionEnabled = true
            sender.isUserInteractionEnabled = true
            views.kawaiImage.image = UIImage(named: "rain")
            views.kawaiImage.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.views.kawaiImage.alpha = 1
            }, completion: { _ in
                self.views.kawaiImage.isHidden = true
                self.views.kawaiImage.alpha = 0
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewModel.lag = false
                sender.setImage(nil, for: .normal)
                self.viewModel.btnArray[self.viewModel.pNum].setImage(nil, for: .normal)
            }
        }
    }

    @IBAction func clickResetBtn(_ sender: Any) {
        random()
        self.views.kawaiImage.isHidden = true
        self.views.kawaiImage.alpha = 0
        viewModel.btnArray.forEach { (btn) in
            btn.isUserInteractionEnabled = true
            btn.setImage(nil, for: .normal)
        }
        self.viewModel.gameTimer?.invalidate()
        self.viewModel.gameTimer = nil
        timerSet()
    }
    
    @IBAction func dismissBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
