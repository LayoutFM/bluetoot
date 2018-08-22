//
//  DataPresenter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

protocol TableViewDataPresenter {
  func registerCells(for tableView: UITableView)
  func cell(for item: Any, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
