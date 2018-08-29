//
//  NotificationsCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationsCoordinator: NSObject, Coordinator, PresentableCoordinatorDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewController = NotificationsTableViewController(provider: NotificationsDataProvider(), presenter: NotificationsDataPresenter())
        viewController.delegate = self
    navigationController.pushViewController(viewController, animated: false)
  }
}

extension NotificationsCoordinator: TootsDelegate {
  func didPressToot(button: UIButton) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
    composeCoordinator.delegate = self
    composeCoordinator.start()

    childCoordinators.append(composeCoordinator)

    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }

  func reply(to status: Status) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
    composeCoordinator.replyToStatus = status
    composeCoordinator.delegate = self
    composeCoordinator.start()

    childCoordinators.append(composeCoordinator)

    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }

  func boost(status: Status) {
    let boost = Statuses.reblog(id: status.id)

    Mastodon.client.run(boost) { result in
      print("You boosted this toot!")
    }
  }
}
