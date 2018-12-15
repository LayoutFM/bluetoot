//
//  StatusDataController.swift
//  BlueToot
//
//  Created by Kevin Clark on 9/3/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class StatusDataController: TableViewDataController {
  var delegate: StatusDelegate?

  func didSelect(item: Any, at indexPath: IndexPath, in tableView: UITableView) {
    guard let status = item as? Status else { return }
    delegate?.showDetail(for: status)
  }

  func leadingSwipeActionsConfiguration(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UISwipeActionsConfiguration? {
    guard let status = item as? Status else { return nil }

    // Reply
    let reply = UIContextualAction(style: .normal, title: "Reply") { (action, view, completionHandler) in
      self.delegate?.reply(to: status)
      completionHandler(true)
    }
    reply.image = UIImage(named: "reply")
    reply.backgroundColor = UIView().tintColor

    // Boost
    let boost = UIContextualAction(style: .normal, title: "Boost") { (action, view, completionHandler) in
      self.delegate?.boost(status: status)
      completionHandler(true)
    }
    boost.image = UIImage(named: "boost")
    boost.backgroundColor = UIColor(red: 25/255, green: 204/255, blue: 71/255, alpha: 1)

    return UISwipeActionsConfiguration(actions: [reply, boost])
  }
}
