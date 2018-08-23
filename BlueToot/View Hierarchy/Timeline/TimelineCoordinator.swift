//
//  TimelineCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit

class TimelineCoordinator: Coordinator, PresentableCoordinatorDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewController = TootsTableViewController(provider: StatusDataProvider(), presenter: StatusDataPresenter())
        viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
}

extension TimelineCoordinator: TootsDelegate {
  func didPressToot(button: UIButton) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
        composeCoordinator.delegate = self
        composeCoordinator.start()

    childCoordinators.append(composeCoordinator)

    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }
}
