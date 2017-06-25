//
//  CorelativeUXTableViewController.swift
//  MasterTableView
//
//  Created by DAIXinming on 25/06/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class CorelativeUXTableViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(bannerImageViewDidTap(_:)))
            bannerImageView.addGestureRecognizer(tap)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 40.0
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.contentInset = UIEdgeInsetsMake(bannerImageViewDefaultHeight, 0.0, 0.0, 0.0)
        }
    }
    
    @IBOutlet weak var bannerImageViewHeightConstraint: NSLayoutConstraint! {
        didSet {
            bannerImageViewHeightConstraint.constant = bannerImageViewDefaultHeight
        }
    }
    
    var bannerImageViewDefaultHeight: CGFloat {
        return UIScreen.main.bounds.width * 1 / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    func bannerImageViewDidTap(_ sender: UITapGestureRecognizer) {
        print("banner image view did tap")
    }

}


extension CorelativeUXTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorelativeUXTableViewCell", for: indexPath)
        cell.textLabel?.text = "row \(indexPath.row)"
        return cell
    }
}


extension CorelativeUXTableViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        bannerImageViewHeightConstraint.constant = offsetY < 0.0 ? -offsetY : 0.0
    }
}
