//
//  TootsTableViewController.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/21/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class TootsTableViewController: UITableViewController {
  let client: Client
  var statuses: [Status] = []

  init(client: Client) {
    self.client = client
    super.init(style: .plain)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Timeline"

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    loadTimeline()
  }

  func loadTimeline() {
    let homeRequest = Timelines.home()

    client.run(homeRequest) { result in
      guard let statuses = result.value else { return }

      DispatchQueue.main.async {
        self.statuses = statuses
        self.tableView.reloadData()
      }
    }
  }

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return statuses.count
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let status = statuses[indexPath.row]
    let formattedContent = status.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

      let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
          cell.textLabel?.numberOfLines = 0
          cell.textLabel?.text = "\(status.account.displayName): \(formattedContent)"

      return cell
  }

}
