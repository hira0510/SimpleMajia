//
//  APIRequest.swift
//  GameAB2
//
//  Created by 王一平 on 2019/7/24.
//  Copyright © 2019 王一平. All rights reserved.
//
import UIKit

class APIRequest {
    var some: [() -> Void] = []
    var answer: [Int] = []
    //   var answerString = ""
    var retryTimes: Int = 0

    func urlRequest() {
        let address = "http://netgoldstone.com/appfile/hw.php"
        if let url = URL(string: address) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse, let jsondata = data {
                    print("status code: \(response.statusCode)")
                    if let number = try? JSONSerialization.jsonObject(with: jsondata, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
//                        let ans = number["answer"] as! String
//                        self.answerString = ans
//                        self.answer = ans.compactMap{Int(String($0))}
                        self.retryTimes = number["retryTimes"] as! Int
                        print("=====\(self.retryTimes)=====")
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL.")
        }
    }
}
