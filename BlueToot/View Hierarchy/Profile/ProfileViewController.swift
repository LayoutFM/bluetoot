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

    let headerView = ProfileHeaderView()

    self.tableView.tableHeaderView = headerView
  }

}
