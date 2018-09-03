//
//  ProfileViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/29/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ProfileTableViewController: TableViewControllerWithDataAdapter {
  var delegate: TootsDelegate?
  
  override init(provider: DataProvider, presenter: TableViewDataPresenter, controller: TableViewDataController? = nil) {
    super.init(provider: provider, presenter: presenter)

    title = "Profile"
    tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataProvider.loadData {
      self.tableView.reloadData()
    }
    
    let headerView = ProfileHeaderView()
    
    self.tableView.tableHeaderView = headerView
    headerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
    headerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
    headerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true

    self.tableView.tableHeaderView?.layoutIfNeeded()
  }
  
  @objc func didPressToot(button: UIButton) {
//    delegate?.didPressToot(button: button)
  }
}
