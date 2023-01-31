//
//  TaiwanService.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/27.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Moya

enum TaiwanService {
    case getTaiwanJson
}

extension TaiwanService: TargetType {

    var baseURL: URL {
        return URL(string: "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json")!
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return nil
    }
}
