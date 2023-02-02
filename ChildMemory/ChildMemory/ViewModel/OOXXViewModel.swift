import UIKit
class OOXXViewModel {
    var xArray: [Int] = []
    var oArray: [Int] = []
    var gameTimer: Timer?
    var btnArray: [UIButton] = []
    var mine: String = ""
    var other: String = ""
    var whoClick: Bool = true
    var time: [String] = {
        return UserDefaults.standard.stringArray(forKey: "time") ?? []
    }()
    var text: [String] = {
        return UserDefaults.standard.stringArray(forKey: "text") ?? []
    }()
    var xArrayRecord: [[Int]] = {
        return UserDefaults.standard.array(forKey: "xArray") as? [[Int]] ?? []
    }()
    var oArrayRecord: [[Int]] = {
        return UserDefaults.standard.array(forKey: "oArray") as? [[Int]] ?? []
    }()
}
