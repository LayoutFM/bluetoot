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
          let dataProvider = StatusDataProvider(client: clientManager.client)
          let dataPresenter = StatusDataPresenter()
          let viewController = TootsTableViewController(provider: dataProvider, presenter: dataPresenter)
          self.navigationController.pushViewController(viewController, animated: false)
        }
  }
}
