import UIKit
class HistoryViewController: UIViewController {
    @IBOutlet weak var mTableView: UITableView!
    var time: [String] = []
    var text: [String] = []
    var oArray: [[Int]] = []
    var xArray: [[Int]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(HistoryTableViewCell.nib, forCellReuseIdentifier: "HistoryTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        time = UserDefaults.standard.stringArray(forKey: "time") ?? []
        text = UserDefaults.standard.stringArray(forKey: "text") ?? []
        oArray = UserDefaults.standard.array(forKey: "oArray") as? [[Int]] ?? []
        xArray = UserDefaults.standard.array(forKey: "xArray") as? [[Int]] ?? []
        mTableView.reloadData()
    }
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if time != [] {
            return time.count
        } else {
            print("尚未有紀錄")
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.configCell(num: indexPath.row + 1, time: time[indexPath.row] , text: text[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Games", bundle: nil).instantiateViewController(withIdentifier: "ToastViewController") as! ToastViewController
        vc.oArray = oArray[indexPath.row]
        vc.xArray = xArray[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}
