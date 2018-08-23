//
//  StatusesAdapter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class StatusDataProvider: ArrayDataProvider {
  var items: [Any] = []

  func loadData(completion: (() -> Void)?) {
    let homeRequest = Timelines.home()

    Mastodon.client.run(homeRequest) { result in
      guard let statuses = result.value else { return }

      DispatchQueue.main.async {
        self.items = statuses
        completion?()
      }
    }
  }
}

class StatusDataPresenter: TableViewDataPresenter {
  func registerCells(for tableView: UITableView) {
    tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
  }

  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let status = item as? Status else { fatalError() }

    let formattedContent = status.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! StatusTableViewCell
    cell.userNameLabel.text = status.account.displayName
    cell.contentLabel.text = formattedContent

    return cell
  }
}
