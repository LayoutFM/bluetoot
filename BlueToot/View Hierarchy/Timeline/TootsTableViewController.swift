//
//  TootsTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/21/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class TootsTableViewController: TableViewControllerWithDataAdapter {
  var delegate: TootsDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Timeline"
    tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "timeline"), tag: 0)
    
    // Set up pull-to-refresh
    let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    // Set up the New Toot button in the Navigation Bar
    let tootButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didPressToot(button:)))
    self.navigationItem.rightBarButtonItem = tootButton

    tableView.separatorInset.left = 80
  }

  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    guard let status = self.dataProvider.item(at: indexPath) as? Status else { return nil }

    // Reply
    let reply = UIContextualAction(style: .normal, title: "Reply") { (action, view, completionHandler) in
      self.delegate?.reply(to: status)
      completionHandler(true)
    }
    reply.image = UIImage(named: "reply")
    reply.backgroundColor = view.tintColor

    // Boost
    let boost = UIContextualAction(style: .normal, title: "Boost") { (action, view, completionHandler) in
      self.delegate?.boost(status: status)
      completionHandler(true)
    }
    boost.image = UIImage(named: "boost")
    boost.backgroundColor = UIColor(red: 25/255, green: 204/255, blue: 71/255, alpha: 1)

    return UISwipeActionsConfiguration(actions: [reply, boost])
  }
  
  @objc func didPressToot(button: UIButton) {
    delegate?.didPressToot(button: button)
  }
}
