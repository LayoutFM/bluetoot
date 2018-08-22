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
  }
}
