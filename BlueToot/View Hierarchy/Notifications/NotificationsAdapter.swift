//
//  NotificationsAdapter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/28/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationsDataProvider: ArrayDataProvider {
  var items: [Any] = []

  func loadData(completion: (() -> Void)?) {
    let notificationsRequest = Notifications.all(range: .limit(50))

    Mastodon.client.run(notificationsRequest) { result in
      guard let notifications = result.value else { return }

      DispatchQueue.main.async {
        self.items = notifications
        completion?()
      }
    }
  }
}

class NotificationsDataPresenter: TableViewDataPresenter {
  let statusesPresenter: StatusDataPresenter

  init(statusesPresenter: StatusDataPresenter) {
    self.statusesPresenter = statusesPresenter
  }

  func registerCells(for tableView: UITableView) {
    statusesPresenter.registerCells(for: tableView)
    tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "notificationCell")
  }

  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let notification = item as? MastodonKit.Notification else { fatalError() }

    if notification.type == .mention {
      return statusesPresenter.cell(for: notification.status!, at: indexPath, in: tableView)
    } else {
      return notificationCell(for: notification, at: indexPath, in: tableView)
    }
  }

  func notificationCell(for notification: MastodonKit.Notification, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableViewCell
        cell.avatarImageView.downloadImage(from: notification.account.avatar)

    var titleText = notification.account.displayName
    switch notification.type {
    case .favourite:
      titleText += " favorited your toot"
      cell.iconImageView.statusIcon.image = UIImage(named: "favorited-badge")
    case .follow:
      titleText += " followed you"
      cell.iconImageView.statusIcon.image = UIImage(named: "followed-badge")
    case .reblog:
      titleText += " boosted your toot"
      cell.iconImageView.statusIcon.image = UIImage(named: "boosted-badge")
    default: break
    }
        cell.titleLabel.text = titleText

    if let status = notification.status {
      let tootFormatter = TootFormatter()
      cell.descriptionLabel.text = tootFormatter.stripHTML(from: status.content)
    } else {
      cell.descriptionLabel.text = ""
    }

    return cell
  }

}
