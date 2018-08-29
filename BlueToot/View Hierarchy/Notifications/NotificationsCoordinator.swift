//
//  NotificationsCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class NotificationsCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewController = NotificationsTableViewController(provider: NotificationsDataProvider(), presenter: NotificationsDataPresenter())
    navigationController.pushViewController(viewController, animated: false)
  }
}
