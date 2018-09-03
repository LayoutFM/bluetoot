//
//  StatusDataPresenter.swift
//  BlueToot
//
//  Created by Kevin Clark on 9/3/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

protocol StatusURLHandler {
  func handle(url: URL)
}

class StatusDataPresenter: NSObject, TableViewDataPresenter {
  var delegate: StatusURLHandler?

  func registerCells(for tableView: UITableView) {
    tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "statusCell")
  }

  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let status = item as? Status else { fatalError() }

    let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! StatusTableViewCell
    cell.contentTextView.delegate = self
    cell.userNameLabel.text = status.account.displayUsername
    cell.contentTextView.text = status.content
    cell.avatarImageView.downloadImage(from: status.account.avatar)
    cell.timeStampLabel.text = TootTimeFormatter().string(from: status.createdAt)
    cell.imageGalleryView.images = status.mediaAttachments.map { $0.previewURL }
    cell.conversation.isHidden = status.inReplyToID == nil

    return cell
  }
}

extension StatusDataPresenter: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    guard interaction == .invokeDefaultAction else {
      return true
    }

    delegate?.handle(url: URL)
    return false
  }
}
