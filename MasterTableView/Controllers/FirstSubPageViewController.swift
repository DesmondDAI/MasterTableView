//
//  FirstSubPageViewController.swift
//  MasterTableView
//
//  Created by DAIXinming on 16/06/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class FirstSubPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2, animations: {
            [unowned self] in
            self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.contentOffset.y - self.refreshControl.frame.height)
        }) { (_) in
            self.refreshControl.beginRefreshing()
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.stopRefreshing), userInfo: nil, repeats: false)
        }
    }
    
    @objc func refreshTableView(_ sender:UIRefreshControl) {
        print("refreshTableView: \(sender)")
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(stopRefreshing), userInfo: nil, repeats: false)
    }
    
    @objc func stopRefreshing() {
        print("stopRefreshing")
        refreshControl.endRefreshing()
    }
}


extension FirstSubPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstSubPageTableViewCell", for: indexPath) as! FirstSubPageTableViewCell
        return cell
    }
}
