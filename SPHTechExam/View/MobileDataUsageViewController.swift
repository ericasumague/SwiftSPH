//
//  MobileDataUsageViewController.swift
//  SPHTechExam
//
//  Created by Erica on 24/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class MobileDataUsageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    let dataViewModel = MobileDataUsageViewModel(requestService: RequestService())
    var yearDataList: [YearlyRecord] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        self.dataViewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.dataViewModel.yearlyData { (dataList) in
            self.yearDataList = dataList
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.yearDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearlyRecordCell") as! YearlyRecordCell
        cell.setData(data: self.yearDataList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yearly: YearlyRecord = self.yearDataList[indexPath.row]
        
        if yearly.hasDescreasingVolume {
            let alert = UIAlertController(title: "Notice", message: "There is a \(yearly.volumeDifference) decrease for Year \(yearly.year)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }

}
