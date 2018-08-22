//
//  DataProvider.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import Foundation

protocol DataProvider {
  func loadData(completion: (() -> Void)?)
  func item(at indexPath: IndexPath) -> Any
  func numberOfSections() -> Int
  func numberOfItems(in section: Int) -> Int
}

extension DataProvider {
  func loadData(completion: (() -> Void)?) {}
}

// Array Data Provider

protocol ArrayDataProvider: DataProvider {
  var items: [Any] {get set}
}

extension ArrayDataProvider {
  func item(at indexPath: IndexPath) -> Any {
    return items[indexPath.row]
  }

  func numberOfSections() -> Int {
    return 1
  }

  func numberOfItems(in section: Int) -> Int {
    return items.count
  }

  mutating func deleteItem(at indexPath: IndexPath) {
    items.remove(at: indexPath.row)
  }
}
