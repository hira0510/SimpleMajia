//
//  TaiwanViewModel.swift
//  TaiwanGoGoGo
//
//  Created by Hira on 2020/4/27.
//  Copyright © 2020 1. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

class TaiwanViewModel {

    private let taiwanApi = TaiwanAPi()
    internal var taiwanSequence = BehaviorRelay<[Info]>(value: [])

    func requestTaiwanData() -> Observable<Bool> {
        return taiwanApi.fetchDataTaiwan().flatMap { [weak self] (object) -> Observable<Bool> in
            guard let `self` = self else { return Observable.just(false) }
            guard object.xmlHead?.infos?.info.count ?? 0 > 0 else { return Observable.just(false) }
            self.taiwanSequence.accept(object.xmlHead?.infos?.info ?? [])
            return Observable.just(true)
        }
    }
}
