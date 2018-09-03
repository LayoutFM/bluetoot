//
//  NotificationsDataController.swift
//  BlueToot
//
//  Created by Kevin Clark on 9/3/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationDataController: TableViewDataController {
  let statusDataController: StatusDataController

  init(statusDataController: StatusDataController) {
    self.statusDataController = statusDataController
  }

  func didSelect(item: Any, at indexPath: IndexPath, in tableView: UITableView) {
    guard let notification = item as? MastodonKit.Notification,
      notification.type == .mention, let status = notification.status else { return }
    statusDataController.didSelect(item: status, at: indexPath, in: tableView)
  }

  func trailingSwipeActionsConfiguration(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UISwipeActionsConfiguration? {
    guard let notification = item as? MastodonKit.Notification,
      notification.type == .mention,
      let status = notification.status else { return UISwipeActionsConfiguration(actions: []) }

    return statusDataController.trailingSwipeActionsConfiguration(for: status, at: indexPath, in: tableView)
  }
}
