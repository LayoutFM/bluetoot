//
//  NotificationsTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationsTableViewController: TableViewControllerWithDataAdapter {
  var delegate: TootsTableViewControllerDelegate?

  override init(provider: DataProvider, presenter: TableViewDataPresenter, controller: TableViewDataController? = nil) {
    super.init(provider: provider, presenter: presenter, controller: controller)

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

    tableView.separatorInset.left = 80

    // Set up the New Toot button in the Navigation Bar
    let tootButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didPressToot(button:)))
    self.navigationItem.rightBarButtonItem = tootButton
  }

  @objc func didPressToot(button: UIButton) {
    delegate?.didPressToot(button: button)
  }
}
