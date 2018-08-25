//
//  TableViewControllerWithAdapter.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class TableViewControllerWithDataAdapter: UITableViewController {
  var dataProvider: DataProvider!
  var dataPresenter: TableViewDataPresenter!

  init(provider: DataProvider, presenter: TableViewDataPresenter) {
    super.init(style: .plain)
    self.dataProvider = provider
    self.dataPresenter = presenter
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    refreshData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    dataPresenter.registerCells(for: tableView)
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return dataProvider.numberOfSections()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataProvider.numberOfItems(in: section)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = dataProvider.item(at: indexPath)
    return dataPresenter.cell(for: item, at: indexPath, in: tableView)
  }

  @objc func refreshData() {
    dataProvider.loadData {
      self.tableView.reloadData()
      self.refreshControl?.endRefreshing()
    }
  }
}
