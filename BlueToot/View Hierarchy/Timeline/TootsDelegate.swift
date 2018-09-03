//
//  TootsDelegate.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/31/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit
import SafariServices

protocol TootsDelegate: PresentableCoordinatorDelegate {
  mutating func reply(to status: Status)
  mutating func boost(status: Status)
  func showDetail(for status: Status)
}

extension TootsDelegate {
  mutating func reply(to status: Status) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
        composeCoordinator.replyToStatus = status
        composeCoordinator.delegate = self
        composeCoordinator.start()

    childCoordinators.append(composeCoordinator)

    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }

  mutating func boost(status: Status) {
    let boost = Statuses.reblog(id: status.id)

    Mastodon.client.run(boost) { result in
      print("You boosted this toot!")
    }
  }

  func showDetail(for status: Status) {
    let dataProvider = StatusDetailDataProvider(status: status)
    let dataPresenter = StatusDataPresenter()
    let dataController = StatusDataController()
    let statusDetail = StatusDetailTableViewController(provider: dataProvider, presenter: dataPresenter, controller: dataController)
    navigationController.pushViewController(statusDetail, animated: true)
  }
}
