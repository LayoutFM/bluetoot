//
//  RootCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let clientManager = ClientManager(baseURL: "https://mastodon.design")
        clientManager.authorize(viewController: navigationController) {
          let viewController = TootsTableViewController(client: clientManager.client)
          self.navigationController.pushViewController(viewController, animated: false)
        }
  }
}
