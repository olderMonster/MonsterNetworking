//
//  CategoryViewController.swift
//  Monster_Example
//
//  Created by mac on 2020/9/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import MonsterNetworking
import SwiftyJSON

class TodayViewController: UIViewController {
    
    lazy var historyTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var historys = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "历史上的今天"
        view.backgroundColor = .white
        
        view.addSubview(historyTableView)
        
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        historyTableView.frame = view.bounds
    }

    
}

//MARK: -- http request
extension TodayViewController {
    
    func loadData() {
        
        APIManager.request(service: NetService.history, methodName: "history/api.php", paramaters:["format": "json"]) { [unowned self] result in
            switch result {
            case .success(let json):
                let jsonArray = JSON(json).arrayValue
                self.historys = jsonArray.compactMap { $0.stringValue }
                self.historyTableView.reloadData()
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
}

extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TodayCell?
        if cell == nil {
            cell = TodayCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        cell!.history = historys[indexPath.row]
        return cell!
    }
}
