//
//  TaiwanModel.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/27.
//  Copyright © 2020 1. All rights reserved.
//

import Foundation
import ObjectMapper

class TaiwanModel: Mappable {

    var xmlHead: XmlHead?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        xmlHead <- map["XML_Head"]
    }
}

class XmlHead: Mappable {

    var infos: Infos?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        infos <- map["Infos"]
    }
}

class Infos: Mappable {

    var info: [Info] = []

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        info <- map["Info"]
    }
}

class Info: Mappable {

    var id: String = ""
    var name: String = ""
    var toldeScribe: String = ""
    var tel: String = ""
    var address: String = ""
    var picture: String = ""
    var px: Double = 0
    var py: Double = 0
    var ticketInfo: String = ""
    var openTime: String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        id <- map["Id"]
        name <- map["Name"]
        toldeScribe <- map["Toldescribe"]
        tel <- map["Tel"]
        address <- map["Add"]
        picture <- map["Picture1"]
        px <- map["Px"]
        py <- map["Py"]
        ticketInfo <- map["Ticketinfo"]
        openTime <- map["Opentime"]
    }
}
