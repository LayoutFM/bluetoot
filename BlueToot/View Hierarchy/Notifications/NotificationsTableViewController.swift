//
//  NotificationsTableViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/24/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class NotificationsTableViewController: TableViewControllerWithDataAdapter {

  init() {
    super.init(coder: .plain)
    title = "Notifications"
    tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "notifications"), tag: 0)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up pull-to-refresh
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
}

