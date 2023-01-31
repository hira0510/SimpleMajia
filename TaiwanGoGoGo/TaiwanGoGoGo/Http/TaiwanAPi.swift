//
//  TaiwanAPi.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/27.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class TaiwanAPi {
    let mainQueue = MainScheduler.instance
    let backQueue = SerialDispatchQueueScheduler.init(qos: .background)
    let provider = MoyaProvider<TaiwanService>()
    
    func fetchDataTaiwan() -> Observable<TaiwanModel> {
        return provider.rx.request(.getTaiwanJson).asObservable().mapObject(TaiwanModel.self).subscribeOn(backQueue).observeOn(mainQueue)
    }
}
