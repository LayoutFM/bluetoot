//
//  NotificationsDataProvider.swift
//  BlueToot
//
//  Created by Kevin Clark on 9/3/18.
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
