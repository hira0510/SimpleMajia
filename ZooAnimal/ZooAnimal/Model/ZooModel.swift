//
//  ZooModel.swift
//  ZooAnimal
//
//  Created by  on 2021/3/31.
//


import Foundation

class ZooModel: Decodable {
    var result: ZooResultModel?
}

class ZooResultModel: Decodable {
    var results: [ZooResultData] = []
}

class ZooResultData: Decodable {

    //中文名
    var a_name_ch: String = ""
    //英文名
    var a_name_en: String = ""
    //門
    var a_phylum: String = ""
    //剛
    var a_class: String = ""
    //目
    var a_order: String = ""
    //科
    var a_family: String = ""
    //地點館
    var a_location: String = ""
    //特性
    var a_behavior: String = ""
    //特徵
    var a_feature: String = ""
    //飲食
    var a_diet: String = ""
    var a_pic01_url: String = ""
    var a_pic02_url: String = ""
    var a_pic03_url: String = ""
    var a_pic04_url: String = ""
}
