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
  override init(provider: DataProvider, presenter: TableViewDataPresenter, controller: TableViewDataController? = nil) {
    super.init(provider: provider, presenter: presenter, controller: controller)

    title = "Profile"
    tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

//    let headerView = self.tableView.tableHeaderView
//    headerView!.translatesAutoresizingMaskIntoConstraints = false
//
//    headerView!.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 0).isActive = true
//    headerView!.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor, constant: 0).isActive = true
//    headerView!.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: 0).isActive = true
//    headerView!.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 0).isActive = true
  }

}
