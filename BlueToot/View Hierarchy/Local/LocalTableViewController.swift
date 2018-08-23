//
//  LocalTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class LocalTableViewController: UITableViewController {
  init() {
    super.init(style: .plain)
    title = "Local"
    tabBarItem = UITabBarItem(title: "Local", image: nil, tag: 0)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .red
  }
}
