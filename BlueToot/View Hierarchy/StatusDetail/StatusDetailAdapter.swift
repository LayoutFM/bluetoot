//
//  StatusDetailAdapter.swift
//  BlueToot
//
//  Created by Kevin Clark on 9/3/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class StatusDetailDataProvider: DataProvider {
  let status: Status
  var items: [[Any]] = []

  init(status: Status) {
    self.status = status
  }

  func loadData(completion: (() -> Void)?) {
    let request = Statuses.context(id: status.id)

    Mastodon.client.run(request) { result in
      guard let context = result.value else { return }

      DispatchQueue.main.async {
        self.items = [
          context.ancestors,
          [self.status],
          context.descendants
        ]
        
        completion?()
      }
    }
  }

  func item(at indexPath: IndexPath) -> Any {
    return items[indexPath.section][indexPath.row]
  }

  func numberOfSections() -> Int {
    return items.count
  }

  func numberOfItems(in section: Int) -> Int {
    return items[section].count
  }
}
