//
//  ZooRequest.swift
//  ZooAnimal
//
//  Created by Hira on 2021/3/31.
//

import UIKit

class ZooRequest {
    
    var some : [() -> Void] = []
    var zooData: [ZooResultData] = []
    
    let address = "https://data.taipei/api/v1/dataset/a3e2b221-75e0-45c1-8f97-75acbd43d613?scope=resourceAquire"
    
    func urlRequest(some : @escaping ([ZooResultData]) -> Void) {
        if let url = URL(string: address) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error:\(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse , let data = data{
                    print("----\(response.statusCode)----")
                    let decoder = JSONDecoder()
                    if let zooArray = try? decoder.decode(ZooModel.self , from: data) {
                        print("----api請求ok----")
                        guard let arrayModel = zooArray.result?.results else { return }
                        for object in arrayModel {
                            self.zooData.append(object)
                        }
                        some(self.zooData)
                    } else {
                        print("no")
                    }
                }
            }
            task.resume()
        }
    }
    
//    func GetImage(url: String, some: @escaping ((UIImage) -> Void)) {
//        if let url = URL(string: url ) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let data = data, let image = UIImage(data: data) {
//                    some(image)
//                } else {
//                    print("no")
//                }
//            }
//            task.resume()
//        }
//    }
}
