//
//  NotificationsAdapter.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/24/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationsDataProvider: ArrayDataProvider {
  var items: [Any] = []
  
  func loadData(completion: (() -> Void)?) {
    let notificationRequest = Notifications.all()
    
    Mastodon.client.run(notificationRequest) { result in
      guard let notifications = result.value else { return }
      
      DispatchQueue.main.async {
        self.items = notifications
        completion?()
      }
    }
  }
}

class NotificationsDataPresenter: TableViewDataPresenter {
  func registerCells(for tableView: UITableView) {
    tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "notiIdentifier")
  }
  
  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let notification = item as? MastodonKit.Notification else { fatalError() }
    
    let formattedContent = notification.status?.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    
    // Downloading user profile pictures
    let url = URL(fileURLWithPath: notification.account.avatar)
    let data = try? Data(contentsOf: url)
    var userProfilePicture = UIImage()
    
    if let imageData = data {
      userProfilePicture = UIImage(data: imageData) ?? UIImage(named: "defaultUserProfilePicture")!
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "notiIdentifier", for: indexPath) as! NotificationTableViewCell
    
    cell.contentLabel.text = formattedContent
    cell.userNameLabel.text = notification.account.username
    cell.profilePicture.image = userProfilePicture
    print(userProfilePicture)
    switch notification.type {
      case .favourite:
          cell.notificationType.text = "Favorited ♥"
      case .follow:
          cell.notificationType.text = "Followed you"
      case .mention:
          cell.notificationType.text = "Mentioned you in a toot"
      case .reblog:
          cell.notificationType.text = "Boosted your toot"
    }

    return cell
  }
}