//
//  SecondSubPageViewController.swift
//  MasterTableView
//
//  Created by DAIXinming on 17/06/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class SecondSubPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var customRefreshControl: UIRefreshControl!
    var refreshControlSubView: CustomRefreshControlSubView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.setContentOffset(CGPoint(x: 0, y: -customRefreshControl.frame.height), animated: true)
        customRefreshControl.sendActions(for: .valueChanged)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40.0
        
        customRefreshControl = UIRefreshControl()
        customRefreshControl.backgroundColor = .clear
        customRefreshControl.tintColor = .clear
        customRefreshControl.addTarget(self, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
        loadCustomRefreshContent()
    }
    
    func refreshControlValueChanged(_ refreshControl: UIRefreshControl) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.refreshControlSubView.refreshIndicatorView.alpha = 0.2
        }, completion: {
            (_) in
            self.refreshControlSubView.refreshIndicatorView.alpha = 1.0
        })
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(stopRefreshing(_:)), userInfo: nil, repeats: false)
    }
    
    func loadCustomRefreshContent() {
        refreshControlSubView = Bundle.main.loadNibNamed("CustomRefreshControl", owner: self, options: nil)?[0] as! CustomRefreshControlSubView
        refreshControlSubView.frame = customRefreshControl.bounds
        refreshControlSubView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        refreshControlSubView.translatesAutoresizingMaskIntoConstraints = true
        customRefreshControl.addSubview(refreshControlSubView)
    }
    
    func stopRefreshing(_ sender: Any) {
        print("stop refreshing: \(sender)")
        refreshControlSubView.refreshIndicatorView.layer.removeAllAnimations()
        customRefreshControl.endRefreshing()
        // Reset any content offset that cannot be reset automatically
        if tableView.contentOffset.y <= -customRefreshControl.frame.height {
            tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }

}


extension SecondSubPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondSubPageTableViewCell", for: indexPath)
        return cell
    }
}
