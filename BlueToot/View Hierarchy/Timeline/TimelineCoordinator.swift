//
//  TimelineCoordinator.swift
//  BlueToot
//
//  Created by Kevin Clark on 8/22/18.
//  Copyright © 2018 Kevin Clark. All rights reserved.
//

import UIKit
import MastodonKit
import SafariServices

class TimelineCoordinator: NSObject, Coordinator, TootsDelegate {
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()

  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let dataProvider = StatusDataProvider()
    let dataPresenter = StatusDataPresenter()
        dataPresenter.delegate = self
    let dataController = StatusDataController()
        dataController.delegate = self
    let viewController = TootsTableViewController(provider: dataProvider, presenter: dataPresenter, controller: dataController)
        viewController.delegate = self
    self.navigationController.pushViewController(viewController, animated: false)
  }
}

extension TimelineCoordinator: TootsTableViewControllerDelegate {
  func didPressToot(button: UIButton) {
    let composeNavigationController = UINavigationController()
    let composeCoordinator = ComposeCoordinator(with: composeNavigationController)
        composeCoordinator.delegate = self
        composeCoordinator.start()

    childCoordinators.append(composeCoordinator)

    navigationController.present(composeNavigationController, animated: true, completion: nil)
  }
}
