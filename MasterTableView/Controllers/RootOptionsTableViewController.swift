//
//  RootOptionsTableViewController.swift
//  MasterTableView
//
//  Created by DAIXinming on 16/06/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class RootOptionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
    }

    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootOptionsTableViewCell") as! RootOptionsTableViewCell
        switch indexPath.row {
        case 0:
            cell.titleNameLabel.text = "UITableView上端的加载指示"
            
        case 1:
            cell.titleNameLabel.text = "自定义UITableView下拉加载提示"
            
        default:
            break
        }
        
        return cell
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "RootOptionGoToFirstSubPage", sender: nil)
            
        case 1:
            performSegue(withIdentifier: "RootOptionGoToSecondSubPage", sender: nil)
            
        default:
            break
        }
    }

}
