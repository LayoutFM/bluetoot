//
//  NotificationsCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit
import SafariServices

class NotificationsCoordinator: NSObject, StatusDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let statusPresenter = StatusDataPresenter()
        statusPresenter.delegate = self
    let presenter = NotificationsDataPresenter(statusesPresenter: statusPresenter)
    let statusDataController = StatusDataController()
        statusDataController.delegate = self
    let dataController = NotificationDataController(statusDataController: statusDataController)
    let viewController = NotificationsTableViewController(provider: NotificationsDataProvider(), presenter: presenter, controller: dataController)
        viewController.delegate = self
    navigationController.pushViewController(viewController, animated: false)
  }
}

extension NotificationsCoordinator: TootsTableViewControllerDelegate {
  func didPressToot(button: UIButton) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
        composeCoordinator.delegate = self
        composeCoordinator.start()

    childCoordinators.append(composeCoordinator)

    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }
}
