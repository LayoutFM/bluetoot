//
//  TootsTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/21/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

protocol TootsDelegate: AnyObject {
  func didPressToot(button: UIButton)
  func reply(to status: Status)
}

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
    let tootButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressToot(button:)))
    self.navigationItem.rightBarButtonItem = tootButton

    tableView.separatorInset.left = 80
  }

  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal, title: "Reply", handler: { (action, view, completionHandler) in
            let status = self.dataProvider.item(at: indexPath) as! Status
            self.delegate?.reply(to: status)
            completionHandler(true)
    })

    action.image = UIImage(named: "reply")
    action.backgroundColor = view.tintColor
    let configuration = UISwipeActionsConfiguration(actions: [action])
    return configuration
  }

//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let status = dataProvider.item(at: indexPath) as! Status
//    delegate?.reply(to: status)
//  }
  
  @objc func didPressToot(button: UIButton) {
    delegate?.didPressToot(button: button)
  }
}
