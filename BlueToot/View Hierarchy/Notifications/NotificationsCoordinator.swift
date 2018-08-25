//
//  NotificationsCoordinator.swift
//  BlueToot
//
//  Created by Rafael Conde on 8/24/18.
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
    viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
}
