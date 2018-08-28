//
//  TootsTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/21/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

protocol TootsDelegate: AnyObject {
  func didPressToot(button: UIButton)
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
    let tootButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didPressToot(button:)))
    self.navigationItem.rightBarButtonItem = tootButton

    tableView.separatorInset.left = 80
  }
  
  @objc func didPressToot(button: UIButton) {
    delegate?.didPressToot(button: button)
  }
}
