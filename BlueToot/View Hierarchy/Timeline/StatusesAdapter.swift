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
    let homeRequest = Timelines.home(range: .limit(100))

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
  var delegate: UITextViewDelegate?

  func registerCells(for tableView: UITableView) {
    tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "statusCell")
  }

  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let status = item as? Status else { fatalError() }

    let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! StatusTableViewCell
        cell.contentTextView.delegate = delegate
        cell.userNameLabel.text = status.account.displayUsername
        cell.contentTextView.text = status.content
        cell.avatarImageView.downloadImage(from: status.account.avatar)
        cell.timeStampLabel.text = TootTimeFormatter().string(from: status.createdAt)
        cell.imageGalleryView.images = status.mediaAttachments.map { $0.previewURL }
        cell.conversation.isHidden = status.inReplyToID == nil

    return cell
  }
}

class StatusDataController: TableViewDataController {
  var delegate: TootsDelegate?

  func didSelect(item: Any, at indexPath: IndexPath, in tableView: UITableView) {
    guard let status = item as? Status else { return }
    delegate?.showDetail(for: status)
  }

  func trailingSwipeActionsConfiguration(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UISwipeActionsConfiguration? {
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
