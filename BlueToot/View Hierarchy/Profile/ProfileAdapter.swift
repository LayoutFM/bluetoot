//
//  ProfileAdapter.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/31/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class ProfileDataProvider: ArrayDataProvider {
  var items: [Any] = []
  
  var account: Account!
  var toots: [Status]!
  
  func loadData(completion: (() -> Void)?) {
    
    Mastodon.client.run(Accounts.currentUser()) { result in
      guard let profile = result.value else { return }
      
      DispatchQueue.main.async {
        self.account = profile
        completion?()
      }
    }
  }
  
  func loadToots() {
    Mastodon.client.run(Accounts.statuses(id: self.account.id)) { result in
      guard let statuses = result.value else { return }
      
      DispatchQueue.main.async {
        self.items = statuses
      }
    }
  }
}

class ProfileDataPresenter: TableViewDataPresenter {
  var delegate: UITextViewDelegate?
  
  
  func registerCells(for tableView: UITableView) {
    tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
  }
  
  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
    guard let status = item as? Status else { fatalError() }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! StatusTableViewCell
    cell.contentTextView.delegate = delegate
    cell.userNameLabel.text = status.account.displayName
    cell.contentTextView.text = status.content
    cell.avatarImageView.downloadImage(from: status.account.avatar)
    cell.timeStampLabel.text = TootTimeFormatter().string(from: status.createdAt)
    cell.imageGalleryView.images = status.mediaAttachments.map { $0.previewURL }
    
    return cell
  }
}

