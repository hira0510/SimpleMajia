//
//  PhotoDrawAndSaveView.swift
//  PictureEdit
//
//  Created by Hira on 2020/2/11.
//  Copyright © 2020 Hira. All rights reserved.
//

import UIKit

class PhotoDrawAndSaveView: NSObject {

    @IBOutlet weak var drawView: DrawAreaView!
    @IBOutlet weak var toolView: ToolbarView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var drawAndImgView: UIView!
    
    var btnArray: [UIButton] = []
    
    func setupToolbarViewXib() {
        btnArray = [toolView.grayColorBtn, toolView.blackColorBtn, toolView.redColorBtn, toolView.orangeColorBtn, toolView.yellowColorBtn, toolView.greenColorBtn, toolView.blueColorBtn, toolView.purpleColorBtn]

        for i in 0..<btnArray.count {
            btnArray[i].addTarget(self, action: #selector(colorBtnClick(sender:)), for: .touchUpInside)
        }
        toolView.cleanBtn.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
        toolView.eraserBtn.addTarget(self, action: #selector(eraserBtnClick), for: .touchUpInside)
        toolView.lineWidthSlider.addTarget(self, action: #selector(widthSliderChange), for: .valueChanged)
    }
    
    ///點擊顏色按鈕->改變slider顏色與畫筆顏色
    @objc func colorBtnClick(sender: UIButton) {
        toolView.lineWidthSlider.tintColor = sender.backgroundColor
        drawView.lineColor = sender.backgroundColor?.cgColor ?? UIColor.gray.cgColor
        toolView.eraserBtn.isEnabled = true
        for i in 0..<btnArray.count {
            btnArray[i].alpha = 1
        }
        sender.alpha = 0.3
    }

    ///移動slider->改變畫筆的寬
    @objc func widthSliderChange() {
        drawView.lineWidth = CGFloat(toolView.lineWidthSlider.value)
    }

    ///點擊clearBtn->清除所有畫筆紀錄
    @objc func clearBtnClick() {
        drawView.path.removeAllPoints()
        drawView.layer.sublayers = nil
        drawView.setNeedsDisplay()
    }

    ///點擊橡皮擦->畫筆變成白色(橡皮擦效果)
    @objc func eraserBtnClick() {
        var color = drawView.backgroundColor
        if color == UIColor.clear {
            color = UIColor.white
        }
        drawView.lineColor = color!.cgColor
        toolView.lineWidthSlider.tintColor = color
        toolView.eraserBtn.isEnabled = false
        for i in 0..<btnArray.count {
            btnArray[i].alpha = 1
        }
    }
}
