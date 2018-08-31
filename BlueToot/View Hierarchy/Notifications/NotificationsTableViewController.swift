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
  var delegate: TootsDelegate?

  override init(provider: DataProvider, presenter: TableViewDataPresenter) {
    super.init(provider: provider, presenter: presenter)

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

  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    guard let notification = self.dataProvider.item(at: indexPath) as? MastodonKit.Notification else { return UISwipeActionsConfiguration(actions: []) }
    guard notification.type == .mention else { return UISwipeActionsConfiguration(actions: []) }

    // Reply
    let reply = UIContextualAction(style: .normal, title: "Reply") { (action, view, completionHandler) in
      self.delegate?.reply(to: notification.status!)
      completionHandler(true)
    }
    reply.image = UIImage(named: "reply")
    reply.backgroundColor = view.tintColor

    return UISwipeActionsConfiguration(actions: [reply])
  }
}
