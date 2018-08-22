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
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Timeline"

    let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    // Set up the New Toot button in the Navigation Bar
    let tootButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushComposeView))
    self.navigationItem.rightBarButtonItem = tootButton
  }
  
  @objc func pushComposeView() {
    print("🆒 You pressed the New Toot button")
    let composeTootVC = ComposeTootViewController()
    self.navigationController?.pushViewController(composeTootVC, animated: true)
  }
}
