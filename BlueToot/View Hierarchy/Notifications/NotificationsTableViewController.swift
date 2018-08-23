//
//  NotificationsTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class NotificationsTableViewController: UITableViewController {
  init() {
    super.init(style: .plain)
    title = "Notifications"
    tabBarItem = UITabBarItem(title: "Notifications", image: nil, tag: 0)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .cyan
  }
}
