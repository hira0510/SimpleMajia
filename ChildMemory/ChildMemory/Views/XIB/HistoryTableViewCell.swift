import UIKit
class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var numLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    static var nib: UINib {
        return UINib(nibName: "HistoryTableViewCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell(num: Int, time: String, text: String) {
        numLable.text = "\(num)"
        timeLable.text = "Time: \(time)"
        titleLable.text = text
    }
}
