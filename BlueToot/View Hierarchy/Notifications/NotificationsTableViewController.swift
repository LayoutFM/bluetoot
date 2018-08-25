//
//  NotificationsTableViewController.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/24/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class NotificationsTableViewController: TableViewControllerWithDataAdapter {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Notifications"
    tabBarItem = UITabBarItem(title: "Notifications", image: nil, tag: 0)
    
    // Set up pull-to-refresh
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
}

