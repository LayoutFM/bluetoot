//
//  TimelineCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class TimelineCoordinator: Coordinator {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var client: Client?

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let client = client else { return }

    let dataProvider = StatusDataProvider(client: client)
    let dataPresenter = StatusDataPresenter()
    let viewController = TootsTableViewController(provider: dataProvider, presenter: dataPresenter)
        viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
}

extension TimelineCoordinator: TootsDelegate {
  func didPressToot(button: UIButton) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
        composeCoordinator.start()
    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }
}
