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
        print("⚡️ INCOMING")
        print(self.items)
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
    guard let notification = item as? Notification else { fatalError() }
    
//    let formattedContent = notification.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//
//    let cell = tableView.dequeueReusableCell(withIdentifier: "notiIdentifier", for: indexPath) as! NotificationTableViewCell
//    cell.contentLabel.text = formattedContent
//
//    return cell
  }
}
