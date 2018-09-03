//
//  NotificationDataPresenter.swift
//  BlueToot
//
//  Created by Kevin Clark on 9/3/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

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
    cell.titleLabel.text = self.sentenceString(for: notification.account.displayUsername, and: notification.type)
    cell.iconImageView.statusIcon.image = self.statusImage(for: notification.type)
    cell.timeStampLabel.text = TootTimeFormatter().string(from: notification.createdAt)

    if let status = notification.status {
      cell.descriptionLabel.text = TootFormatter().stripHTML(from: status.content)
    } else {
      cell.descriptionLabel.text = ""
    }

    return cell
  }

  func statusImage(for notificationType: NotificationType) -> UIImage? {
    switch notificationType {
    case .favourite: return UIImage(named: "favorited-badge")
    case .follow: return UIImage(named: "followed-badge")
    case .reblog: return UIImage(named: "boosted-badge")
    default: return nil
    }
  }

  func sentenceString(for displayName: String, and notificationType: NotificationType) -> String {
    switch notificationType {
    case .favourite: return "\(displayName) favorited your toot"
    case .follow: return "\(displayName) followed you"
    case .reblog: return "\(displayName) boosted your toot"
    default: return ""
    }
  }

}
